resource "aws_api_gateway_rest_api" "api" {
    name = "music-discovery-companion-api"
}

resource "aws_api_gateway_deployment" "get_artist" {
  depends_on = [aws_api_gateway_integration.get_artist_lambda]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "test"
}

resource "aws_api_gateway_resource" "get_artist" {
  path_part   = "artist"
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "get_artist" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.get_artist.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_artist_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.get_artist.id
  http_method             = aws_api_gateway_method.get_artist.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.get_artist.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.get_artist.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:eu-west-1:757782070749:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.get_artist.http_method}${aws_api_gateway_resource.get_artist.path}"
}