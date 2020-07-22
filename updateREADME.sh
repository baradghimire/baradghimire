#!/bin/bash
UNSPLASH_TOKEN=$1
UNSPLASH_RESPONSE=`curl -s -X GET https://api.unsplash.com/photos/random/?query=nature\&featured=true -H "Authorization: Client-ID $UNSPLASH_TOKEN"`
RAW_URL=`echo "$UNSPLASH_RESPONSE" | jq -r '.urls.raw'`
RAW_TAG='<img src=\"'$RAW_URL'/&fm=jpg&crop=faces&fit=crop&h=540&w=1920\"/>'
IMG_TAG=$(sed 's|&|\\&|g' <<< $RAW_TAG)
sed -i "" "1s~.*~$IMG_TAG~" README.md