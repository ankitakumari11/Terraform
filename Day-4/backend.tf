terraform {
  backend "s3" {
    bucket         = "abhishek-s3-demo-xyz" # change this
    key            = "abhi/terraform.tfstate"  # this will store the terraform statefile inside abhi/ folder
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
