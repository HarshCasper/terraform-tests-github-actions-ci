run "verify_s3_buckets" {
  command = plan

  assert {
    condition     = aws_s3_bucket.original_images.bucket == "original-images"
    error_message = "Original images bucket not created with correct name"
  }

  assert {
    condition     = aws_s3_bucket.resized_images.bucket == "resized-images"
    error_message = "Resized images bucket not created with correct name"
  }
}

run "verify_lambda_function" {
  command = apply

  assert {
    condition     = output.lambda_function_arn != null
    error_message = "Lambda function not created"
  }
}
