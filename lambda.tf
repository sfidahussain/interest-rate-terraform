resource "aws_iam_role" "iam_for_lambda" {
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
      "Effect": "Allow"
    }
  ]
}
EOF
}

provider "archive" {}

data "archive_file" "rate_zip" {
  type        = "zip"
  source_file = "py/rate_processor_function.py"
  output_path = "rate_processor_function.zip"
}

data "archive_file" "all_zip" {
  type        = "zip"
  source_file = "py/get_all_rates_processor_function.py"
  output_path = "get_all_rates_processor_function.zip"
}

data "archive_file" "latest_zip" {
  type        = "zip"
  source_file = "py/get_latest_rate_processor_function.py"
  output_path = "get_latest_rate_processor_function.zip"
}

data "archive_file" "specific_zip" {
  type        = "zip"
  source_file = "py/get_specific_time_rate_processor_function.py"
  output_path = "get_specific_time_rate_processor_function.zip"
}

resource "aws_lambda_permission" "allow_bucket1" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func1.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}

resource "aws_lambda_permission" "allow_bucket2" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func2.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}

resource "aws_lambda_permission" "allow_bucket3" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func3.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}

resource "aws_lambda_permission" "allow_bucket4" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func4.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}
# Rate Processor Lambda
# This is what parses a file once it is uploaded to the S3 Bucket
# And inserts the records in a Dynamo DB Table
resource "aws_lambda_function" "func1" {
  function_name = "rate_processor"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "rate_processor_function.lambda_handler"
  filename         = "${data.archive_file.rate_zip.output_path}"
  source_code_hash = "${data.archive_file.rate_zip.output_base64sha256}"
  runtime       = "python3.6"
}

# Get All Rates Lambda
resource "aws_lambda_function" "func2" {
  function_name = "get_all_rates_processor"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "get_all_rates_processor_function.lambda_handler"
  filename         = "${data.archive_file.all_zip.output_path}"
  source_code_hash = "${data.archive_file.all_zip.output_base64sha256}"
  runtime       = "python3.6"
}

# Get Specific Rate Lambda
resource "aws_lambda_function" "func3" {
  function_name = "get_specific_rate_processor"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "get_specific_rate_processor_function.lambda_handler"
  filename         = "${data.archive_file.specific_zip.output_path}"
  source_code_hash = "${data.archive_file.specific_zip.output_base64sha256}"
  runtime       = "python3.6"
}

# Get Latest Rate Lambda
resource "aws_lambda_function" "func4" {
  function_name = "get_latest_rate_processor"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "get_latest_rate_processor_function.lambda_handler"
  filename         = "${data.archive_file.latest_zip.output_path}"
  source_code_hash = "${data.archive_file.latest_zip.output_base64sha256}"
  runtime       = "python3.6"
}