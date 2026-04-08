# aws-vault-ldap-k8s-ad

Terraform Cloud Stacks scaffold for the Active Directory / LDAP slice of the `aws-vault-ldap-k8s` demo.

This repository is intended to own the Windows domain controller, LDAPS prerequisites, and LDAP-facing metadata that Vault will use later for password rotation. It should stay focused on the AD layer; the EKS platform, Vault runtime, and demo application belong in the sibling repos.

## Stack purpose

- provision the demo Active Directory / LDAP foundation on AWS
- prepare LDAPS connectivity and directory metadata for Vault integration
- publish AD outputs that downstream stacks can consume through linked stacks

## Upstream linked-stack contract

Current scaffold assumption: this stack will consume shared network/platform outputs from `aws-vault-ldap-k8s-k8s`.

Planned upstream inputs:

- VPC and subnet placement for the domain controller
- shared internal security group or equivalent network attachment details
- shared naming/prefix metadata for the overall demo

Additional deployment inputs should come from Terraform Cloud Stacks deployment values and varsets, such as `region`, `customer_name`, `user_email`, `allowlist_ip`, and `instance_type`.

## Downstream linked-stack contract

Planned outputs for downstream stacks, especially `aws-vault-ldap-k8s-vault`:

- domain controller private IP and public DNS
- LDAPS endpoint and certificate/bootstrap metadata
- Active Directory domain naming data (for example bind DN and user DN context)
- secret references needed to bootstrap Vault's LDAP integration
- demo service account or static role metadata used by the Vault stack

## Terraform Cloud Stacks

This repo is scaffolded around Terraform Stacks root files:

- `components.tfcomponent.hcl`
- `providers.tfcomponent.hcl`
- `variables.tfcomponent.hcl`
- `deployments.tfdeploy.hcl`

The HCL files are placeholders only. Later todos should replace them with real component wiring, linked-stack attachments, and extracted modules.
