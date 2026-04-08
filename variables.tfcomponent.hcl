variable "region" {
  description = "AWS region for the Active Directory deployment."
  type        = string
  default     = "us-east-2"
}

variable "vpc_id" {
  description = "VPC ID where the domain controller will be deployed."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the domain controller EC2 instance will be placed."
  type        = string
}

variable "shared_internal_sg_id" {
  description = "Security group ID shared with the rest of the demo for internal communication."
  type        = string
}

variable "prefix" {
  description = "Prefix used to name AWS resources created by this stack."
  type        = string
}

variable "allowlist_ip" {
  description = "IP CIDR allowed to reach the domain controller over RDP and Kerberos."
  type        = string
  default     = "66.190.197.168/32"
}

variable "domain_controller_instance_type" {
  description = "EC2 instance type for the Active Directory domain controller."
  type        = string
  default     = "c5.xlarge"
}

variable "domain_controller_ami_id" {
  description = "Optional AMI override for the domain controller. Use to pin a known-good image when the default hc-base image regresses."
  type        = string
  default     = null
}

variable "full_ui" {
  description = "When true, use the Windows Server Desktop Experience AMI instead of the hardened Server Core AMI."
  type        = bool
  default     = false
}

variable "install_adds" {
  description = "When true, install Active Directory Domain Services and promote the instance to a domain controller."
  type        = bool
  default     = true
}

variable "install_adcs" {
  description = "When true, install Active Directory Certificate Services so LDAPS is available on port 636."
  type        = bool
  default     = true
}

variable "active_directory_domain" {
  description = "Active Directory domain name created by the domain controller."
  type        = string
  default     = "mydomain.local"
}

variable "active_directory_netbios_name" {
  description = "NetBIOS short name for the Active Directory domain."
  type        = string
  default     = "mydomain"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key ID provided by the shared Terraform Cloud environment variable set."
  type        = string
  ephemeral   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key provided by the shared Terraform Cloud environment variable set."
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "AWS_SESSION_TOKEN" {
  description = "AWS session token provided by the shared Terraform Cloud environment variable set."
  type        = string
  sensitive   = true
  ephemeral   = true
}
