output "ec2_key_pair_name" {
  value = aws_key_pair.my-key.key_name
}

output "ec2_public_ip" {
  description = "Public IPs of all EC2 instances"
  value = [
    for instance in aws_instance.my-aws_instance : instance.public_ip
  ]
}

output "ec2_public_dns" {
  description = "Public DNS of all EC2 instances"
  value = [
    for instance in aws_instance.my-aws_instance : instance.public_dns
  ]
}

output "ec2_private_ip" {
  description = "Private IPs of all EC2 instances"
  value = [
    for  instance in aws_instance.my-aws_instance : instance.private_ip
  ]
}

output "ssh_commands" {
  description = "SSH commands to connect to each EC2 instance"
  value = [
    for instance in aws_instance.my-aws_instance : "ssh -i terra-key-ec2 ${local.ssh_username}@${instance.public_dns}"
  ]
}


# output "ec2_public_ip" {
#   value = aws_instance.my-aws_instance[*].public_ip # for count add *
# }

# output "ec2_public_dns" {
#   value = aws_instance.my-aws_instance[*].public_dns # for count add *
# }

# output "ec2_private_ip" {
#   value = aws_instance.my-aws_instance[*].private_ip # for count add *
# }

# output "ssh_command" {
#   value       = "ssh -i terra-key-ec2 ${local.ssh_username}@${aws_instance.my-aws_instance.public_dns}"
#   description = "SSH command to connect to the EC2 instance"
# }