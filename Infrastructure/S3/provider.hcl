generate "provider" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    terraform {
      backend "local" {}
      required_providers {
        aws =  "~> 3.48"
      }
      required_version = "~> 1.5"
    }
    provider "aws" {
      region = "us-east-1"
    }
  EOF
}