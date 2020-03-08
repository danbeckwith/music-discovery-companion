module "get_artist" {
  source = "./modules/get-artist-lambda"
}

output "get_artist_arn" {
  value = module.get_artist.get_artist_lambda_arn
}
