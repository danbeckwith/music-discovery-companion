module "get_artist" {
  source = "./modules/get-artist"

  assume_role_arn = aws_iam_role.lambda_assume_role.arn
  client_secret = var.client_secret
}

module "authorisation" {
  source = "./modules/authorisation"
  
  assume_role_arn = aws_iam_role.lambda_assume_role.arn
  client_secret = var.client_secret
}

output "get_artist_invoke_arn" {
  value = module.get_artist.invoke_arn
}

output "get_artist_arn" {
  value = module.get_artist.arn
}

output "authorisation_invoke_arn" {
  value = module.authorisation.invoke_arn
}

output "authorisation_arn" {
  value = module.authorisation.arn
}


