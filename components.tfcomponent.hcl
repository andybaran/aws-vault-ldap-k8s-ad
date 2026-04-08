component "active_directory" {
  source = "./modules/AWS_DC"

  inputs = {
    allowlist_ip                    = var.allowlist_ip
    vpc_id                          = var.vpc_id
    subnet_id                       = var.subnet_id
    ami                             = var.domain_controller_ami_id
    domain_controller_instance_type = var.domain_controller_instance_type
    shared_internal_sg_id           = var.shared_internal_sg_id
    prefix                          = var.prefix
    active_directory_domain         = var.active_directory_domain
    active_directory_netbios_name   = var.active_directory_netbios_name
    full_ui                         = var.full_ui
    install_adds                    = var.install_adds
    install_adcs                    = var.install_adcs
  }

  providers = {
    aws    = provider.aws.this
    tls    = provider.tls.this
    random = provider.random.this
    time   = provider.time.this
  }
}
