#!/bin/bash
set -e

pushd pipeline/terraform
terraform init
terraform apply -auto-approve 
popd

aws s3 sync content/ s3://nde-devportal-docs.niketech.com/ --exclude \"*.DS_Store*\"; exit_status=$?; if [ $exit_status
-eq 2 ]; then exit 0; fi; exit $exit_status