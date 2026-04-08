---
applyTo: "*.tf,*.hcl,*.md"
---

# Project: aws-vault-ldap-k8s-ad

## Goal

Own the Active Directory / LDAP infrastructure slice of the demo. The overall demo still uses Terraform Cloud Stacks to show Vault rotating AD credentials for an app running on EKS, but this repo should stay focused on the AD layer only.

## Scope

- Windows domain controller and LDAP/LDAPS prerequisites
- stack outputs that publish LDAP connectivity and bootstrap metadata
- Terraform Stacks root files and contract documentation for this repo

## Guardrails

- Keep using Terraform Stacks root files; do not collapse this repo back to plain Terraform.
- Keep this repo limited to AD concerns. Do not add Vault runtime, EKS platform, or app workloads here.
- Treat linked-stack contracts as part of the API: update variables, outputs, and README together.
- Prefer simple demo-friendly code, but keep secrets out of git and out of documentation examples.
- Preserve the assumption that networking comes from the `aws-vault-ldap-k8s-k8s` stack unless a later refactor changes the contract explicitly.
