output "ec2_ip" {
    description = "IP publico da instancia EC2"
    value = aws_instance.lab-vm.public_ip
}