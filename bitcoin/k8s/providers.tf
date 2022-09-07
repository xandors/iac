# export AWS_PROFILE=infradev
# export AWS_REGION=us-east-1

terraform {
  required_providers {
    aws = {}
  }
}

provider "aws" {}
