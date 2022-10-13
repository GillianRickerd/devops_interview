terraform {
  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = var.env
      Owner       = "Gillian"
      Project     = "devops_interview"
    }
  }
}