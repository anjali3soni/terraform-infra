## SSh Key Pair for Bastion Host
resource "aws_key_pair" "bastion" {
  key_name   = "${local.env.environment}-bastion-key"
  public_key = file("${terraform.workspace}/bastion.pub")

  depends_on = [aws_security_group.bastion]
}

### SSH Key Pair for Instances
resource "aws_key_pair" "instance" {
  key_name   = "${local.env.environment}-instance-key"
  public_key = file("${terraform.workspace}/instance.pub")
}
