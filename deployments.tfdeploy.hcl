store varset "aws_creds" {
  id       = "varset-oUu39eyQUoDbmxE1"
  category = "env"
}

upstream_input "k8s_foundation" {
  type   = "stack"
  source = "app.terraform.io/andybaran/ldap stack/aws-vault-ldap-k8s-k8s"
}

deployment "development" {
  inputs = {
    region                          = "us-east-2"
    vpc_id                          = upstream_input.k8s_foundation.vpc_id
    subnet_id                       = upstream_input.k8s_foundation.public_subnet_id
    shared_internal_sg_id           = upstream_input.k8s_foundation.shared_internal_sg_id
    prefix                          = upstream_input.k8s_foundation.resources_prefix
    allowlist_ip                    = "66.190.197.168/32"
    domain_controller_instance_type = "c5.xlarge"
    domain_controller_ami_id        = "ami-0538f3e03d5cbff42"
    full_ui                         = false
    install_adds                    = true
    install_adcs                    = true
    active_directory_domain         = "mydomain.local"
    active_directory_netbios_name   = "mydomain"

    AWS_ACCESS_KEY_ID     = store.varset.aws_creds.AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY = store.varset.aws_creds.AWS_SECRET_ACCESS_KEY
    AWS_SESSION_TOKEN     = store.varset.aws_creds.AWS_SESSION_TOKEN
  }
}

publish_output "dc_private_ip" {
  value = deployment.development.dc_private_ip
}

publish_output "ldap_url" {
  value = deployment.development.ldap_url
}

publish_output "active_directory_domain" {
  value = deployment.development.active_directory_domain
}

publish_output "ldap_binddn" {
  value = deployment.development.ldap_binddn
}

publish_output "ldap_userdn" {
  value = deployment.development.ldap_userdn
}

publish_output "ldap_bootstrap_secret_arn" {
  value = deployment.development.ldap_bootstrap_secret_arn
}
