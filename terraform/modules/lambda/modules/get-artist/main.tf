resource "aws_lambda_function" "get_artist" {
  function_name = "get-artist"

  s3_bucket = "music-discovery-companion-lambda-source"
  s3_key    = "get-artist/0.0.2-SNAPSHOT/get-artist-lambda.zip"

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
  value = aws_lambda_function.get_artist.arn
}

output "invoke_arn" {
  value = aws_lambda_function.get_artist.invoke_arn
}

output "name" {
  value = aws_lambda_function.get_artist.function_name
}
