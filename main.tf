terraform {
  required_version = ">= 0.13.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.30.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "ap_northeast"
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_net_mask = var.vpc_net_mask
}

module "subnet" {
  source         = "./modules/subnet"
  vpc_net_mask   = var.vpc_net_mask
  vpc_id         = module.vpc.vpc_id
  route_table_id = module.vpc.route_table_id
}

module "sg" {
  source      = "./modules/security_group"
  name        = "isucon_sg"
  vpc_id      = module.vpc.vpc_id
  cidr_blocks = split(",", var.access_cidr_blocks)
}

module "credential" {
  source = "./modules/credential"
}

module "ec2_webapp" {
  source             = "./modules/ec2"
  category           = "webapp"
  ami_name           = var.webapp.ami_name
  ami_owner          = var.webapp.ami_owner
  subnet_id          = module.subnet.subnet_id
  security_group_id  = module.sg.security_group_id
  credential_key_id  = module.credential.credential_key_id
  ec2_instance_type  = var.webapp.ec2_instance_type
  ec2_instance_count = var.webapp.ec2_instance_count
  ec2_volume_size    = var.webapp.ec2_volume_size
}

module "ec2_bench" {
  source             = "./modules/ec2"
  category           = "bench"
  ami_name           = var.bench.ami_name
  ami_owner          = var.bench.ami_owner
  subnet_id          = module.subnet.subnet_id
  security_group_id  = module.sg.security_group_id
  credential_key_id  = module.credential.credential_key_id
  ec2_instance_type  = var.bench.ec2_instance_type
  ec2_instance_count = 1
  ec2_volume_size    = var.bench.ec2_volume_size
}

output "webapp_public_ip" {
  value = module.ec2_webapp.instance_public_id_addr
}

output "webapp_private_ip" {
  value = module.ec2_webapp.instance_private_id_addr
}

output "bench_public_ip" {
  value = module.ec2_bench.instance_public_id_addr
}