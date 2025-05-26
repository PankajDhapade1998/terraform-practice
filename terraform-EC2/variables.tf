variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ec2_default_root_storage_size" {
  default = 8 # change if its windows then 30GB
  type    = number
}

variable "os_type" {
  type    = string
  default = "ubuntu" #change this as per OS
}

variable "env" {
  default = "dev" # change it to prd when you are in production environment 30 GB size
}

locals {
  os_ami_name_map = {
    "ubuntu"       = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    "amazon-linux" = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
  }

  os_owners = {
    "ubuntu"       = "099720109477"
    "amazon-linux" = "137112412989"
  }

  os_ssh_usernames = {
    "ubuntu"       = "ubuntu"
    "amazon-linux" = "ec2-user"
  }

  ssh_username = lookup(local.os_ssh_usernames, var.os_type)

}





