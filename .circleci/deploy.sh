#!/bin/bash
set -e

# DEPENDS ON THE FOLLOWING ENVIRONMENT VARIABLES BEING SET BY CI
: "${terraform_state_bucket?Unset variable}"

pushd pipeline/terraform
terraform init \
       -backend-config bucket="${terraform_state_bucket}"
terraform apply -auto-approve
popd

aws s3 sync content/ s3://nde-devportal-docs.niketech.com/ --exclude \"*.DS_Store*\"; exit_status=$?; if [ $exit_status
-eq 2 ]; then exit 0; fi; exit $exit_status