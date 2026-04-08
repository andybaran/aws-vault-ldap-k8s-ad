# aws-vault-ldap-k8s-ad

Terraform Cloud Stacks repository for the Active Directory / LDAP slice of the `aws-vault-ldap-k8s` demo.

This repo owns the Windows domain controller, AD DS / AD CS setup for LDAP and LDAPS, and the downstream-facing LDAP metadata that Vault will consume later. Networking and shared security groups come from the sibling k8s foundation stack.

## Scope

- provision a Windows Server 2025 domain controller on AWS
- promote the instance to `mydomain.local` and optionally enable AD CS for LDAPS
- publish the LDAP connection contract used by downstream Vault stacks
- keep the split narrowly focused on the AD layer only

## Repository layout

- `modules/AWS_DC/` - copied from the source monolith and kept as the local AD module for this split stack
- `variables.tfcomponent.hcl` - repo-level input contract for the AD stack
- `providers.tfcomponent.hcl` - AWS, TLS, random, and time provider configuration
- `components.tfcomponent.hcl` - Active Directory component wiring
- `outputs.tfcomponent.hcl` - operator-facing stack outputs
- `deployments.tfdeploy.hcl` - deployment defaults, linked-stack wiring, and published outputs

## Upstream dependency

This stack consumes networking and shared security group data from the k8s foundation stack:

- upstream stack source: `app.terraform.io/andybaran/ldap-stack/aws-vault-ldap-k8s-k8s`
- shared AWS credentials varset: `varset-oUu39eyQUoDbmxE1`

Current deployment wiring assumes the upstream stack publishes the following values, based on the source monolith contract:

| Upstream published output | Local AD input |
| --- | --- |
| `vpc_id` | `vpc_id` |
| `first_public_subnet_id` | `subnet_id` |
| `shared_internal_sg_id` | `shared_internal_sg_id` |
| `resources_prefix` | `prefix` |

## Deployment defaults

The default `development` deployment preserves the source demo behavior where reasonable:

| Input | Default |
| --- | --- |
| `region` | `us-east-2` |
| `allowlist_ip` | `66.190.197.168/32` |
| `domain_controller_instance_type` | `c5.xlarge` |
| `full_ui` | `false` |
| `install_adds` | `true` |
| `install_adcs` | `true` |
| `active_directory_domain` | `mydomain.local` |
| `active_directory_netbios_name` | `mydomain` |

## Published downstream outputs

The deployment publishes only the values needed by downstream stacks:

- `dc_private_ip`
- `ldap_url`
- `active_directory_domain`
- `ldap_binddn`
- `ldap_userdn`
- `ldap_bindpass`
- `static_roles_json`

Operator-facing outputs such as `dc_public_dns`, `dc_elastic_ip`, and `dc_admin_password` remain normal stack outputs and are not published as linked-stack contract values.

## Validation

Run the repository validation commands from the repo root:

```bash
terraform fmt -recursive
terraform stacks fmt
terraform stacks init
terraform stacks validate
```
