resource "aws_lambda_function" "get_artist" {
  function_name = "get-artist"

  s3_bucket = "music-discovery-companion-lambda-source"
  s3_key    = "get-artist/0.0.1-SNAPSHOT-b3/get-artist-lambda.zip"

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

output "get_artist_lambda_arn" {
  value = aws_lambda_function.get_artist.arn
}
