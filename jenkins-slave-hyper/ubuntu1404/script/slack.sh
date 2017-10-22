#!/bin/bash

TOKEN="$1"
CHANNEL_ID="$2"
MESSAGE="$3"
ATTACHMENT="$4"
NICK="HykinsBot"
EMOJI=":jenkins:"

curl -X POST \
-F token="$TOKEN" \
-F channel="$CHANNEL_ID" \
-F text="$MESSAGE" \
-F username="$NICK" \
-F attachments="$ATTACHMENT" \
-F icon_emoji="$EMOJI" \
https://slack.com/api/chat.postMessage
