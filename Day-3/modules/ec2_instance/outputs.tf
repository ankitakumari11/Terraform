output "public-ip-address" {
  value = aws_instance.example.public_ip  # resource.resource_name.public_ip
}
