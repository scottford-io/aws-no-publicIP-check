terraform {
  backend "s3" {
    bucket     = "tf-remote-state20210901011426035100000002"
    key        = "aws-no-publicIP-check/terraform.tfstate"
    region     = "us-east-1"
    encrypt    = true
    kms_key_id = "	b90f0db1-6d30-43b2-8e63-845c98db00b6"
  }
}

provider "aws" {
  region = "us-east-1"
}