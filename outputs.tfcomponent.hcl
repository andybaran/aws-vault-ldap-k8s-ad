locals {
  ldap_base_dn = join(",", [for label in split(".", var.active_directory_domain) : "DC=${label}"])
  ldap_scheme  = var.install_adcs ? "ldaps" : "ldap"
}

output "dc_private_ip" {
  description = "Private IP address of the domain controller."
  type        = string
  value       = component.active_directory.dc-priv-ip
}

output "ldap_url" {
  description = "LDAP or LDAPS URL for the domain controller, depending on AD CS configuration."
  type        = string
  value       = "${local.ldap_scheme}://${component.active_directory.dc-priv-ip}"
}

output "active_directory_domain" {
  description = "Active Directory DNS domain used by the demo."
  type        = string
  value       = var.active_directory_domain
}

output "ldap_binddn" {
  description = "Bind DN for the default Administrator account."
  type        = string
  value       = "CN=Administrator,CN=Users,${local.ldap_base_dn}"
}

output "ldap_userdn" {
  description = "Base DN that contains the demo LDAP users."
  type        = string
  value       = "CN=Users,${local.ldap_base_dn}"
}

output "ldap_bindpass" {
  description = "Secrets Manager ARN containing the LDAP bind password and static role seed data."
  type        = string
  value       = component.active_directory.ldap_bootstrap_secret_arn
}

output "static_roles" {
  description = "Compatibility alias for the Secrets Manager ARN containing the LDAP bootstrap payload."
  type        = string
  value       = component.active_directory.ldap_bootstrap_secret_arn
}

output "dc_public_dns" {
  description = "Public DNS name of the domain controller Elastic IP."
  type        = string
  value       = component.active_directory.public-dns-address
}

output "dc_elastic_ip" {
  description = "Elastic IP address assigned to the domain controller."
  type        = string
  value       = component.active_directory.eip-public-ip
}

output "dc_admin_password" {
  description = "Secrets Manager ARN containing the Windows administrator password and LDAP bootstrap payload."
  type        = string
  value       = component.active_directory.ldap_bootstrap_secret_arn
}

output "ldap_bootstrap_secret_arn" {
  description = "Secrets Manager ARN containing the LDAP bind password and static role seed data."
  type        = string
  value       = component.active_directory.ldap_bootstrap_secret_arn
}
