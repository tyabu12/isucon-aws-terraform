resource "aws_key_pair" "default" {
  key_name   = "isucon_key"
  public_key = file("./modules/credential/isucon_id_rsa.pub")
}