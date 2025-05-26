#key pair (login)

resource "aws_key_pair" "my-key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

#VPC & securrity group

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my-security-group" {
  name        = "automate-sg"
  description = "this will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH Open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "jenkins"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "automate-sg"
  }
}

resource "aws_instance" "my-aws_instance" {
  key_name        = aws_key_pair.my-key.key_name
  security_groups = [aws_security_group.my-security-group.name]
  instance_type   = var.ec2_instance_type
  ami             = data.aws_ami.selected.id
  # user_data = file("user_data.sh")

  root_block_device {
    volume_size = var.ec2_root_storage_size
    volume_type = "gp3"
  }

  # instance_market_options {
  #   market_type = "spot"

  #   spot_options {
  #     spot_instance_type             = "one-time"
  #     instance_interruption_behavior = "terminate"
  #   }
  # }


  tags = {
    Name = "Ubuntu"
  }
}

