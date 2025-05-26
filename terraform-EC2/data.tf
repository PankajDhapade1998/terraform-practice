
data "aws_ami" "selected" {
  most_recent = true

  filter {
    name   = "name"
    values = [lookup(local.os_ami_name_map, var.os_type)]
  }

  owners = [lookup(local.os_owners, var.os_type)]
}
