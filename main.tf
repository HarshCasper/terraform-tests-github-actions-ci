terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
  }
}

resource "aws_s3_bucket" "original_images" {
  bucket        = "original-images"
  force_destroy = true
  tags = {
    Name = "Original Images Bucket"
  }
}

resource "aws_s3_bucket" "resized_images" {
  bucket        = "resized-images"
  force_destroy = true
  tags = {
    Name = "Resized Images Bucket"
  }
}

resource "aws_lambda_function" "image_resizer" {
  filename      = "lambda.zip"
  function_name = "ImageResizerFunction"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  timeout       = 60
  role          = "arn:aws:iam::000000000000:role/lambda-role"
}

resource "aws_s3_bucket_notification" "original_images_notification" {
  bucket = aws_s3_bucket.original_images.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.image_resizer.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.image_resizer.arn
}
