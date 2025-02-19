#!/bin/bash

AZURE_METADATA_URL="http://169.254.169.254/metadata/instance?api-version=2021-02-01"
HEADERS="-H Metadata:true"

# Function to fetch metadata
get_azure_metadata() {
    local key=$1
    local json=$(curl -s $HEADERS "$AZURE_METADATA_URL")

    if [ -z "$key" ]; then
        echo "$json" | jq '.'
    else
        echo "$json" | jq -c ".${key} // {\"error\": \"Key not found\"}"
    fi
}

# Main function
main() {
    local key=$1
    get_azure_metadata "$key"
}

main "$1"
