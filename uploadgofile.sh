#!/bin/bash

if [[ "$#" == "0" ]]; then
    echo "ERROR: No file specified!"
    exit 1
fi

FILE="$1"

echo "Getting GoFile server..."

SERVER=$(curl -s https://api.gofile.io/servers | jq -r '.data.servers[0].name')

echo "Using server: $SERVER"

RESPONSE=$(curl -s \
    -H "Authorization: Bearer $GOFILE_API_KEY" \
    -F "file=@$FILE" \
    "https://${SERVER}.gofile.io/uploadFile")

echo "$RESPONSE"

LINK=$(echo "$RESPONSE" | jq -r '.data.downloadPage')

echo ""
echo "Download link: $LINK"
