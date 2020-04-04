resource "aws_lambda_function" "authorisation" {
  function_name = "authorisation"

  s3_bucket = "music-discovery-companion-lambda-source"
  s3_key    = "authorisation/0.0.1-SNAPSHOT/authorisation-lambda.zip"

  role = var.assume_role_arn

  handler = "index.handler"
  runtime = "nodejs12.x"

  environment {
    variables = {
      CLIENT_ID = "6aa76e948d424e93b1262ed96a9e0e4d"
      CLIENT_SECRET = var.client_secret
    }
  }
}

output "arn" {
  value = aws_lambda_function.authorisation.arn
}

output "invoke_arn" {
  value = aws_lambda_function.authorisation.invoke_arn
}

output "name" {
  value = aws_lambda_function.authorisation.function_name
}
