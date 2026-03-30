output "student_connections" {
  value = {
    for name, instance in aws_instance.student : name => {
      public_ip   = instance.public_ip
      ssh_command = "ssh ubuntu@${instance.public_ip}"
    }
  }
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}
