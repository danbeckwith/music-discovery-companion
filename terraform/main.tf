module "get_artist" {
  source = "./modules/get-artist-lambda"

  client_secret = data.aws_kms_secrets.client_secret.plaintext["client_secret"]
}

output "get_artist_arn" {
  value = module.get_artist.arn
}
