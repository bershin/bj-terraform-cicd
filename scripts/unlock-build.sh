#!/bin/bash

set -e

# Check if there is an existing PR checker run - if there is, wait

PROJECT_ID=$1
LOCK_FILE="gs://${PROJECT_ID}-cloudbuild-lock/tf-build.lck"

gsutil rm ${LOCK_FILE} > /dev/null 2> /dev/null || true

exit 0
