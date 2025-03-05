#!/bin/bash

set -euo pipefail

# Set up a variable to hold the meta-data from your block step
RELEASE_NAME="$(buildkite-agent meta-data get "release-name")"
RELEASE_TYPE="$(buildkite-agent meta-data get "release-type")"

# Create a pipeline with your trigger step
PIPELINE="steps:
  - trigger: \"eft-sure-$RELEASE_TYPE-deployment\"
    label: \"Trigger deploy to $RELEASE_NAME\"
    build:
      meta_data:
        release-type: $RELEASE_TYPE
        release-name: $RELEASE_TYPE
"

# Upload the new pipeline and add it to the current build
echo "$PIPELINE" | buildkite-agent pipeline upload
