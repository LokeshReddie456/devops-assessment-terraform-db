output "db_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
output "db_address" {
  value = aws_db_instance.postgres.address
}
output "db_port" {
  value = aws_db_instance.postgres.port
}
output "master_user_secret_arn" {
  value = aws_db_instance.postgres.master_user_secret[0].secret_arn
}
