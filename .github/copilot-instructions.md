---
applyTo: "*.tf,*.hcl,*.md"
---

# Project: aws-vault-ldap-k8s-ad

## Goal

Own the Active Directory / LDAP infrastructure slice of the demo. This repo should stay focused on the Windows domain controller, LDAP/LDAPS prerequisites, and the outputs that downstream stacks need for Vault integration.

## Scope

- Terraform Stacks root files for the AD split repo
- the local `modules/AWS_DC` module copied from the source monolith
- linked-stack inputs from the k8s foundation stack
- published LDAP bootstrap metadata for downstream consumers

## Stack contracts

- Upstream stack source is assumed to be `app.terraform.io/andybaran/ldap-stack/aws-vault-ldap-k8s-k8s` unless the repo is updated to a new contract.
- The deployment currently maps upstream `vpc_id`, `first_public_subnet_id`, `shared_internal_sg_id`, and `resources_prefix` outputs into the local `vpc_id`, `subnet_id`, `shared_internal_sg_id`, and `prefix` inputs.
- Publish only the downstream values required for Vault/bootstrap consumers: `dc_private_ip`, `ldap_url`, `active_directory_domain`, `ldap_binddn`, `ldap_userdn`, `ldap_bindpass`, and `static_roles`.

## Guardrails

- Keep this repo on Terraform Stacks; do not collapse it back to plain Terraform.
- Keep the repo limited to AD concerns. Do not add Vault runtime, EKS platform, or app workloads here.
- Treat linked-stack variables, outputs, README content, and deployment wiring as a single API surface; update them together.
- Keep the copied `AWS_DC` module close to the source version and adapt it only when the split repo requires it.
- Do not default deployments to `destroy = true`.
- Keep sensitive values out of git and out of documentation examples.
