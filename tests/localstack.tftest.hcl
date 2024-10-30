variables {
  original_bucket_name = "original-images"
  resized_bucket_name  = "resized-images"
  image_path      = "image.png"
  test_image_key       = "image.png"
}

run "setup" {
  module {
    source = "./"
  }
}

run "execute" {
  module {
    source = "./tests/execute"
  }
}

run "verify" {
  module {
    source = "./tests/verify"
  }

  assert {
    condition     = data.aws_s3_bucket_object.resized_image.id != ""
    error_message = "Resized image not found in resized-images bucket"
  }
}
