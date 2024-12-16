# Instance 1
resource "aws_instance" "instance_1" {
  ami                    = local.env.instance_ami
  instance_type          = local.env.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.instance.key_name
  subnet_id              = module.vpc.private_subnets[0]

  user_data = file("userdata/userdata.sh")

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = local.env.instance_volume
    volume_type           = "gp2"
    delete_on_termination = true
    tags = {
      Terraform   = "true"
      Environment = "${local.env.environment}-vpc"
      Name        = "${local.env.environment}-instance-1"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "${local.env.environment}-vpc"
    Name        = "${local.env.environment}-instance-1"
  }

  depends_on = [aws_security_group.instance, aws_key_pair.instance]
}

# Instance 2
resource "aws_instance" "instance_2" {
  ami                    = local.env.instance_ami
  instance_type          = local.env.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.instance.key_name
  subnet_id              = module.vpc.private_subnets[1]

  user_data = file("userdata/userdata.sh")

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = local.env.instance_volume
    volume_type           = "gp2"
    delete_on_termination = true
    tags = {
      Terraform   = "true"
      Environment = "${local.env.environment}-vpc"
      Name        = "${local.env.environment}-instance-2"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "${local.env.environment}-vpc"
    Name        = "${local.env.environment}-instance-2"
  }

  depends_on = [aws_security_group.instance, aws_key_pair.instance]
}

# Instance 3
resource "aws_instance" "instance_3" {
  ami                    = local.env.instance_ami
  instance_type          = local.env.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.instance.key_name
  subnet_id              = module.vpc.private_subnets[2]

  user_data = file("userdata/userdata.sh")

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = local.env.instance_volume
    volume_type           = "gp2"
    delete_on_termination = true
    tags = {
      Terraform   = "true"
      Environment = "${local.env.environment}-vpc"
      Name        = "${local.env.environment}-instance-3"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "${local.env.environment}-vpc"
    Name        = "${local.env.environment}-instance-3"
  }

  depends_on = [aws_security_group.instance, aws_key_pair.instance]
}


