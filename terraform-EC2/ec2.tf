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
  # count = 2 # meta argument (will create 2 instances)
  for_each = tomap({
    jenkins = "t2.micro"
    # server  = "t2.micro"
  }) # meta argument key value

  depends_on = [ aws_security_group.my-security-group, aws_key_pair.my-key ]

  key_name        = aws_key_pair.my-key.key_name
  security_groups = [aws_security_group.my-security-group.name]
  instance_type   = each.value
  ami             = data.aws_ami.selected.id
  user_data       = file("user_data.sh")

  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2_default_root_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }


  # instance_market_options {
  #   market_type = "spot"

  #   spot_options {
  #     spot_instance_type             = "one-time"
  #     instance_interruption_behavior = "terminate"
  #   }
  # }

}

# resource "aws_instance" "my_imported_instance" {
#   ami = "unknown"
#   instance_type = "unknown"
# }


# To import EC2 instance from aws to terraform ,create template

# commands for importing 

# terraform import aws_instance.my_imported_instance i-05ee4ee67830b44ff
# terraform state list
# terraform state show aws_instance.my_imported_instance #(will show details of instance)



