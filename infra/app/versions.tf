terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  # One state per environment; the pipeline passes the key:
  #   terraform init -backend-config="key=services/shop-api/<env>.tfstate"
  backend "s3" {
    bucket       = "devops94-idp-tfstate-697502032879"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      project     = "devops94-idp"
      component   = "shop-api"
      owner       = "group:default/platform-admins"
      environment = var.environment
      stack       = "service-shop-api-${var.environment}"
      managed-by  = "terraform"
    }
  }
}
