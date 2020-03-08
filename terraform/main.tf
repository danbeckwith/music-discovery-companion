module "get_artist" {
  source = "./modules/get-artist-lambda"

  client_secret = aws_secretsmanager_secret.client_secret.arn
}

output "get_artist_arn" {
  value = module.get_artist.arn
}
