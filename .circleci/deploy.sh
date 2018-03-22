#!/bin/bash
set -e

WORKSPACE=${1}

# DEPENDS ON THE FOLLOWING ENVIRONMENT VARIABLES BEING SET BY CI
: "${terraform_state_bucket?Unset variable}"
: "${s3_site_bucket?Unset variable}"

pushd pipeline/terraform
terraform init \
       -backend-config bucket="${terraform_state_bucket}"
# If the workspace doesn not exist, create it.
if ! terraform workspace select ${WORKSPACE}; then
    terraform workspace new ${WORKSPACE} 
fi
terraform init \
       -backend-config bucket="${terraform_state_bucket}"
terraform apply -auto-approve
popd

aws s3 sync content/ s3://$s3_site_bucket/ --exclude \"*.DS_Store*\"; exit_status=$?; if [ $exit_status
-eq 2 ]; then exit 0; fi; exit $exit_status