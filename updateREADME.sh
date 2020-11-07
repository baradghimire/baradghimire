#!/bin/bash
TKN=$1
RES=`curl -s -X GET https://api.unsplash.com/photos/random/?query=nature -H "Authorization: Client-ID $TKN"`
URL=`echo "$RES" | jq -r '.urls.raw'`
USR=`echo "$RES" | jq -r '.user.username'`
LNK=`echo "$RES" | jq -r '.links.html'`
TDY=`date +'%d/%m/%Y'`
TAG='<img src=\"'$URL'/&fm=jpg&crop=faces&fit=crop&h=540&w=1920\"/><sup>Photo by ['$USR']('$LNK') on [Unsplash](https://unsplash.com)</sup><sup>Last updated: ['$TDY'](https://github.com/baradghimire/baradghimire/blob/main/.github/workflows/autoUpdateREADME.yml)</sup>'
HDR=$(sed 's|&|\\&|g' <<< $TAG)
sed -i "1s~.*~$HDR~" README.md
