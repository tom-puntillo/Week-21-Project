# Specify the S3 bucket as the backend for Terraform state storage
terraform {
  backend "s3" {
    bucket = "my-terraform-luit-week21-state-tjp" # Define your S3 bucket name
    key    = "aws/terraform"                      # Define the desired path to the state file within the bucket
    region = "us-east-1"                          # Define your desired AWS region for the S3 bucket
  }

  # Define the required version of Terraform for this configuration
  required_version = ">= 1.0.0"

  # Specify the required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0" # Require version 3.0 or higher of the AWS provider
    }
  }
}
