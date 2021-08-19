#!/bin/bash

set -e

# Check if there is an existing PR checker run - if there is, wait

PROJECT_ID=$1
BUCKET="${PROJECT_ID}-cloudbuild-lock"
LOCK_FILE="gs://${BUCKET}/tf-build.lck"
_count=0
_locked=0

# Check if bucket exists, if not, make it.
if ! gsutil ls gs://$BUCKET; then
  gsutil mb gs://$BUCKET
fi


# Check if the build is locked
if gsutil ls ${LOCK_FILE} > /dev/null 2> /dev/null; then
  _locked=1
fi

# Wait a maximum of 25 mins before carrying on anyways
# This should have allowed the previous PR check to have finished
while [ ${_count} -lt 25 ] && [ ${_locked} -ne 0 ]; do
  let _count=$_count+1
  if gsutil ls ${LOCK_FILE} > /dev/null 2> /dev/null; then
    _locked=1
    echo "Terraform run in progress waiting 60 seconds (count $_count) locked ($_locked)"
    sleep 60
  else
    _locked=0
  fi
done

if [ ${_locked} -eq 0 ]; then
  date +%d-%m-%Y > $(basename ${LOCK_FILE})
  echo $(basename ${LOCK_FILE})
  gsutil cp $(basename ${LOCK_FILE}) ${LOCK_FILE}
else
  echo "Failed to secure a Terraform build lock"
  exit 1
fi

exit 0
