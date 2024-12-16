resource "aws_eip" "bastion" {
  domain   = "vpc"
  instance = aws_instance.bastion.id

  tags = {
    Terraform   = "true"
    Environment = "${local.env.environment}-vpc"
    Name        = "${local.env.environment}-bastion"
  }

  depends_on = [aws_instance.bastion]
}