provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"

  s3_use_path_style           = true
  skip_requesting_account_id  = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true

  endpoints {
    s3             = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

variable "original_bucket_name" {
  type = string
}

variable "image_path" {
  type = string
}

variable "test_image_key" {
  type = string
}

resource "aws_s3_bucket_object" "test_image" {
  bucket = var.original_bucket_name
  key    = var.test_image_key
  source = var.image_path
}
