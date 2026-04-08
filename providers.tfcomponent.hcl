required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "6.27.0"
  }
  tls = {
    source  = "hashicorp/tls"
    version = "~> 4.0.5"
  }
  random = {
    source  = "hashicorp/random"
    version = "~> 3.6.0"
  }
  time = {
    source  = "hashicorp/time"
    version = "0.13.1"
  }
}

provider "aws" "this" {
  config {
    region     = var.region
    access_key = var.AWS_ACCESS_KEY_ID
    secret_key = var.AWS_SECRET_ACCESS_KEY
    token      = var.AWS_SESSION_TOKEN
  }
}

provider "tls" "this" {
}

provider "random" "this" {
}

provider "time" "this" {
}
