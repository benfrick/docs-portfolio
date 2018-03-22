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
  domain_name        = "nde-devportal-docs${local.domain_prefix}.niketech.com"
  domain_prefix             = "${lookup(local.acccount_values[local.account], "domain_prefix")}"
  hosted_zone_id             = "${lookup(local.acccount_values[local.account], "hosted_zone_id")}"
  domain_certificate_arn = "${lookup(local.acccount_values[local.account], "certificate_arn")}"

  # multi account mapping. Get the account from the workspace, default to preprod
  account = "${lookup(local.acccount_values["accounts"], terraform.workspace, "preprod")}"

  acccount_values = {
    accounts = {
      prod    = "prod"
      preprod = "preprod"
    }

    preprod = {
      domain_prefix             = ".preprod"
      hosted_zone_id         = "Z37T3L5WQDRXPJ"
      certificate_arn        = "arn:aws:acm:us-east-1:919740896133:certificate/5b6ef643-48a9-4bdd-9e4d-351ae5aa4d94"
    }

    prod = {
      domain_prefix            = ""
      hosted_zone_id         = "Z7OWM2GFULVOF"
      certificate_arn        = "arn:aws:acm:us-east-1:370680818641:certificate/03bf66ad-dd3b-414a-a20e-45b2403ba6a2"
    }
}
