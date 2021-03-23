# API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name = "interest_api"
}

resource "aws_api_gateway_resource" "rate" {
  path_part   = "rate"
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "latest" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.rate.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "specific" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.rate.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_resource" "all" {
  path_part   = "all"
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "all" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.all.id
  http_method   = "GET"
  authorization = "NONE"
}