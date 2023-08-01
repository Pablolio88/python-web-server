terraform {
  source = "./terraform//"
}

locals {
  common = read_terragrunt_config("provider.hcl")
}

generate = local.common.generate

remote_state {
  backend = "local"
  config = {
    path = "/terraform-state/${lookup(lookup(yamldecode(file(find_in_parent_folders("environment.yaml"))), "remote_state_config"), "bucket")}.tfstate"
  }
}

inputs = {
  create                          = true
  name                            = lookup(lookup(yamldecode(file(find_in_parent_folders("environment.yaml"))), "remote_state_config"), "bucket")
  tags                            = lookup(yamldecode(file(find_in_parent_folders("environment.yaml"))), "tags")
  enable_versioning               = true
  server_side_encryption_algoritm = "aws:kms"
  policy                          = <<-EOF
    {
        "Version": "2012-10-17",
        "Id": "Deny HTTP Access",
        "Statement": [
            {
                "Sid": "AllowSSLRequestsOnly",
                "Effect": "Deny",
                "Principal": "*",
                "Action": "s3:*",
                "Resource": [
                    "arn:aws:s3:::${lookup(lookup(yamldecode(file(find_in_parent_folders("environment.yaml"))), "remote_state_config"), "bucket")}",
                    "arn:aws:s3:::${lookup(lookup(yamldecode(file(find_in_parent_folders("environment.yaml"))), "remote_state_config"), "bucket")}/*"
                ],
                "Condition": {
                    "Bool": {
                        "aws:SecureTransport": "false"
                    }
                }
            }
        ]
    }
    EOF
}