output "public_ip" {
  value = aws_instance.training.public_ip
}

output "ssh_command" {
  value = "ssh ubuntu@${aws_instance.training.public_ip}"
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}
