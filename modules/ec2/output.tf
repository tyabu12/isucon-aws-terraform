output "aws_instance" {
  value = aws_instance.participant-instance.*.id
}

output "instance_public_id_addr" {
  value = aws_instance.participant-instance.*.public_ip
}

output "instance_private_id_addr" {
  value = aws_instance.participant-instance.*.private_ip
}