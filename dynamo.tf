resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Rates"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "timestamp"

  attribute {
    name = "timestamp"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name        = "dynamodb-rates-table"
    Environment = "dev"
  }
}