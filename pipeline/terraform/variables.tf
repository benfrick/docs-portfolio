terraform {
    backend "s3" {
      key    = "nde"
      region = "us-west-2"
      workspace_key_prefix = "nde"
    }
}

variable "region" {
  default = "us-west-2"
}

provider "aws" {
  region = "${var.region}"
}

variable "app_namespace" {
  default = "ngp_apps_rocket"
}

locals {
  # account-based values
  domain_certificate_arn = "${lookup(local.acccount_values[local.account], "certificate_arn")}"
  hosted_zone_id = "${lookup(local.acccount_values[local.account], "hosted_zone_id")}"
  domain_name = "rocket${terraform.workspace == "prod" ? "" : "-${terraform.workspace}"}.niketech.com"

  # multi account mapping. Get the account from the workspace, default to lab
  account = "${lookup(local.acccount_values["accounts"], terraform.workspace, "lab")}"
  acccount_values = {
    accounts = {
      prod = "prod"
      preprod = "preprod"
    }
    lab = {
      hosted_zone_id = "Z16CU76US5IGCZ"
      certificate_arn = "arn:aws:acm:us-east-1:539783510382:certificate/1958390f-ab4f-4ba4-93f8-7e9b1931e379"
    }
    preprod = {
      hosted_zone_id = "ZHWWRI5RPI209"
      certificate_arn = "arn:aws:acm:us-east-1:539783510382:certificate/1958390f-ab4f-4ba4-93f8-7e9b1931e379"
    }
    prod = {
      # prod is not ready, see below
      # prod = "Z7OWM2GFULVOF"
      # prod = "arn:aws:acm:us-east-1:370680818641:certificate/03bf66ad-dd3b-414a-a20e-45b2403ba6a2"

      # still using lab values
      hosted_zone_id = "Z16CU76US5IGCZ"
      certificate_arn = "arn:aws:acm:us-east-1:539783510382:certificate/1958390f-ab4f-4ba4-93f8-7e9b1931e379"
    }
  }
}
