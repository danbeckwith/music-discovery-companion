resource "aws_lambda_function" "get_artist" {
  function_name = "get-artist"

  s3_bucket = "music-discovery-companion-lambda-source"
  s3_key    = "get-artist/0.0.2-SNAPSHOT-b4/get-artist-lambda.zip"

  role = aws_iam_role.lambda_assume_role.arn

  handler = "index.handler"
  runtime = "nodejs12.x"
}

resource "aws_iam_role" "lambda_assume_role" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_basic_exec" {
  role       = aws_iam_role.lambda_assume_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "client_secret_read_access" {
  role = aws_iam_role.lambda_assume_role.name
  policy_arn = aws_iam_policy.client_secret_read_access.arn
}

resource "aws_iam_policy" "client_secret_read_access" {
  name = "lambda_client_secret_read_access"
  policy = data.aws_iam_policy_document.client_secret_read_access.json
}

data "aws_iam_policy_document" "client_secret_read_access" {
  statement {
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]

    resources = [
      var.client_secret
    ]
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
