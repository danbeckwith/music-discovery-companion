resource "aws_secretsmanager_secret" "client_secret" {
  name = "clientSecret"
}

resource "aws_secretsmanager_secret_version" "client_secret_value" {
  secret_id     = aws_secretsmanager_secret.client_secret.id
  secret_string = var.client_secret
}