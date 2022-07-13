variable "category" {
  type = string
}
variable "ami_name" {
  type = string
}
variable "ami_owner" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "security_group_id" {
  type = string
}
variable "credential_key_id" {
  type = string
}
variable "ec2_instance_type" {
  type = string
}
variable "ec2_instance_count" {
  type = number
}
variable "ec2_volume_size" {
  type = number
}