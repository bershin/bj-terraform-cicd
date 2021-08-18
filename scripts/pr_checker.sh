#!/bin/bash
set -e

cd terraform
INIT_FLAGS="-backend-config=prefix=${gcp_project} -backend-config=bucket=terraform-state-bj-dev-vpc -backend=false"
echo $INIT_FLAGS
terraform init $INIT_FLAGS

terraform fmt -diff -list=false -write=false .
terraform validate .