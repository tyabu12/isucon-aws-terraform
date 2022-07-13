resource "aws_instance" "participant-instance" {
  ami                         = data.aws_ami.standalone_ami.id
  count                       = var.ec2_instance_count
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.credential_key_id
  security_groups             = [var.security_group_id]

  root_block_device {
    volume_type           = "standard"
    volume_size           = var.ec2_volume_size
    delete_on_termination = true
  }

  tags = {
    Name     = var.ec2_instance_count == 1 ? format("isucon-%s", var.category) : format("isucon-%s-%02d", var.category, count.index + 1)
    Category = var.category
  }
}