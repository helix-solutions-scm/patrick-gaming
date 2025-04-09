output "public_dns" {
    value = aws_instance.test_server.public_dns
}

output "publicipaddr" {
  value = aws_instance.test_server.public_ip
}