provider "aws" {
  region  = "us-east-1"
  version = "~> 1.46.0"
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    encrypt = "true"
  }
}
