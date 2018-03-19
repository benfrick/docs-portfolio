terraform {
  backend "s3" {
    key                  = "nde-devportal-docs"
    region               = "us-west-2"
    workspace_key_prefix = "nde-devportal-docs"
  }
}

variable "region" {
  default = "us-west-2"
}

provider "aws" {
  region = "${var.region}"
}

locals {
  domain_name            = "nde-devportal-docs.niketech.com"
  hosted_zone_id         = "Z7OWM2GFULVOF"
  domain_certificate_arn = "arn:aws:acm:us-east-1:370680818641:certificate/03bf66ad-dd3b-414a-a20e-45b2403ba6a2"
}
