terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_s3_bucket" "aws_logs" {
  bucket = "${local.aws_account_id}-aws-logs"
  acl    = "log-delivery-write"

  tags = {
    Name        = "${local.aws_account_id}-aws-logs"
    Environment = "Test"
  }

  force_destroy = true
}

resource "aws_s3_bucket" "aws" {
  bucket = "${local.aws_account_id}-aws"
  acl = "private"

  logging {
    target_bucket = aws_s3_bucket.aws_logs.id
    target_prefix = "TFStateLogs/"
  }

  tags = {
    Name = "aws"
    Owner = "InfraTeam"
  }
}

data "aws_caller_identity" "current" {
}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}


