terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

# Default region specified as us-west-2
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

# DB Postgres Engine
# This is where data is persisted when a user uploads a file
# with file information and interest rate records within each file.
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "11.10"
  instance_class       = "db.t3.micro"
  name                 = "devdb"
  username             = "foo"
  password             = "foobarbaz"
  skip_final_snapshot  = true
}
