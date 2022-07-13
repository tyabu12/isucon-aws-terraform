variable "webapp" {
  type = object({
    ami_owner          = string
    ami_name           = string
    ec2_instance_type  = string
    ec2_instance_count = number
    ec2_volume_size    = number
  })
  default = {
    ami_name           = "isuconXX-qualify"
    ami_owner          = "839726181030" # owner of https://github.com/matsuu/aws-isucon
    ec2_instance_type  = "t2.micro"
    ec2_instance_count = 3
    ec2_volume_size    = 20
  }
  description = "webapp instance"
}

variable "bench" {
  type = object({
    ami_owner         = string
    ami_name          = string
    ec2_instance_type = string
    ec2_volume_size   = number
  })
  default = {
    ami_name          = "isuconXX-qualify"
    ami_owner         = "839726181030" # owner of https://github.com/matsuu/aws-isucon
    ec2_instance_type = "t2.micro"
    ec2_volume_size   = 20
  }
  description = "benchmarker instance"
}

variable "access_cidr_blocks" {
  type        = string
  default     = "0.0.0.0/0" # "0.0.0.0/0,255.255.255.255/32" のようにカンマ区切りで複数指定可
  description = "cidr for access"
}

variable "vpc_net_mask" {
  type        = string
  default     = "10.1.0.0"
  description = "VPC network subnet mask"
}