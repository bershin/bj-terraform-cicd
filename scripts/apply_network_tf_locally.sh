#!/bin/bash
set -e

PROJECT_ID=$1

if [ "${PROJECT_ID}" == "" ]; then
  echo "You must specify a GCP project to run against."
  echo "The specified project must match the SA keys in tf_sa.json"
  exit 1
fi

CUR_DIR=$(pwd)
PARALLELISM=10

SERVICE_ACCOUNT_JSON=${CUR_DIR}/tf_sa.json
INIT_FLAGS="-backend-config=prefix=${PROJECT_ID}-database -backend-config=bucket=terraform-state-bj-dev-vpc"

echo "################# Navigate to the directory ###############"
cd terraform-network/

echo "################## Terraform init stage ##################"
GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform init $INIT_FLAGS

echo ""
echo "################## Terraform providers  ##################"
GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform providers

echo ""
echo "################## Terraform apply (module.vpc) ##################"
GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform apply -parallelism=${PARALLELISM} -auto-approve -var-file=${CUR_DIR}/tfvars/${PROJECT_ID}.tfvars
