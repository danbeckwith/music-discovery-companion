module "lambda" {
  source = "./modules/lambda"
  
  client_secret = data.aws_kms_secrets.client_secret.plaintext["client_secret"]
}

output "get_artist_arn" {
  value = module.lambda.get_artist_arn
}

output "authorisation_arn" {
  value = module.lambda.authorisation_arn
}

output "get_artist_invoke_arn" {
  value = module.lambda.get_artist_invoke_arn
}

output "authorisation_invoke_arn" {
  value = module.lambda.authorisation_invoke_arn
}

