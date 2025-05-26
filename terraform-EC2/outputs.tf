output "ec2_public_ip" {
  value = aws_instance.my-aws_instance.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.my-aws_instance.public_dns
}

output "ec2_private_ip" {
  value = aws_instance.my-aws_instance.private_ip
}

output "ec2_key_pair_name" {
  value = aws_key_pair.my-key.key_name
}

output "ssh_command" {
  value       = "ssh -i terra-key-ec2 ${local.ssh_username}@${aws_instance.my-aws_instance.public_dns}"
  description = "SSH command to connect to the EC2 instance"
}

