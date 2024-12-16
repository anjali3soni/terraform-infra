resource "aws_instance" "bastion" {
  ami                    = local.env.bastion_ami
  instance_type          = local.env.bastion_instance_type
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name               = aws_key_pair.bastion.key_name
  subnet_id              = module.vpc.public_subnets[0]

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = local.env.bastion_volume
    volume_type           = "gp2"
    delete_on_termination = true
    tags = {
      Terraform   = "true"
      Environment = "${local.env.environment}-vpc"
      Name        = "${local.env.environment}-bastion"
      type        = "bastion"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "${local.env.environment}-vpc"
    Name        = "${local.env.environment}-bastion"
  }

  depends_on = [aws_key_pair.bastion]
}
