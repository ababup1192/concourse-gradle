#!/bin/sh

set -eu

# Incoming WebHooks URL
WEBHOOKURL="https://hooks.slack.com/services/xxxx/xxxxxx"

# Bot name
BOTNAME=${BOTNAME:-"Concourse"}
# Icon
FACEICON=${FACEICON:-":ghost:"}

# Create Message
status=`cat ./result/status`
if test $status -eq 0  ; then
    WEBMESSAGE=":ok:\tTest Success"
else
    WEBMESSAGE=":no_entry_sign:\tTest Failed"
fi

# Post Message
curl -s -S -X POST --data-urlencode "payload={\"username\": \"${BOTNAME}\", \"icon_emoji\": \"${FACEICON}\", \"text\": \"${WEBMESSAGE}\" }" ${WEBHOOKURL} >/dev/null

