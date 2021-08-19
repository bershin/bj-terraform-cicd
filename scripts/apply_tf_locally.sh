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
INIT_FLAGS="-backend-config=prefix=${PROJECT_ID} -backend-config=bucket=terraform-state-bj-dev-vpc"

cd terraform/
echo "################## Terraform init stage ##################"
GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform init $INIT_FLAGS

echo ""
echo "################## Terraform providers  ##################"
GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform providers

echo ""
echo "################## Terraform apply (module.vpc) ##################"
GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform apply -parallelism=${PARALLELISM} -auto-approve -target module.sql-db_private_service_access -var-file=${CUR_DIR}/tfvars/${PROJECT_ID}.tfvars

# echo ""
# echo "################## Terraform apply (module.dns_private_zone) ##################"
# GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform apply -parallelism=${PARALLELISM} -auto-approve -target module.dns_private_zone -target random_id.k8s_role_suffix -var-file=${CUR_DIR}/tfvars/${PROJECT_ID}.tfvars

# echo ""
# echo "################## Terraform apply (module.gke-us-west1) ##################"
# GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform apply -parallelism=${PARALLELISM} -auto-approve -target module.gke-us-west1 -target random_id.ops_sa_suffix -target module.custom-k8s-role -var-file=${CUR_DIR}/tfvars/${PROJECT_ID}.tfvars

# echo ""
# echo "################## Terraform plan (rest) ##################"
# GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform plan -parallelism=${PARALLELISM} -out=plan.out -var-file=${CUR_DIR}/tfvars/${PROJECT_ID}.tfvars

# echo ""
# echo "################## Terraform apply (rest) ##################"
# GOOGLE_CLOUD_KEYFILE_JSON="$SERVICE_ACCOUNT_JSON" GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_JSON" terraform apply -parallelism=${PARALLELISM} plan.out
