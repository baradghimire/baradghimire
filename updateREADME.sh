#!/bin/bash
UNSPLASH_TOKEN=$1
UNSPLASH_RESPONSE=`curl -s -X GET https://api.unsplash.com/photos/random/?query=nature -H "Authorization: Client-ID $UNSPLASH_TOKEN"`
RAW_URL=`echo "$UNSPLASH_RESPONSE" | jq -r '.urls.raw'`
USR_NAME=`echo "$UNSPLASH_RESPONSE" | jq -r '.user.username'`
IMG_LINK=`echo "$UNSPLASH_RESPONSE" | jq -r '.links.html'`
RAW_TAG='<img src=\"'$RAW_URL'/&fm=jpg&crop=faces&fit=crop&h=540&w=1920\"/><sup>Photo by ['$USR_NAME']('$IMG_LINK') on [Unsplash](https://unsplash.com)</sup>'
HEADER=$(sed 's|&|\\&|g' <<< $RAW_TAG)
sed -i "1s~.*~$HEADER~" README.md
