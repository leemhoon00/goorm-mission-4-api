output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "server_subnet_id" {
  value = aws_subnet.server.id
}

output "database_subnet_id" {
  value = aws_subnet.database.id
}
