#!/bin/sh

set -eu

#Incoming WebHooksのURL
WEBHOOKURL="https://hooks.slack.com/services/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"
#メッセージを保存する一時ファイル
MESSAGEFILE=`mktemp -t webhooks`
trap "
rm ${MESSAGEFILE}
" 0

usage_exit() {
    echo "Usage: $0 [-m message] [-c channel] [-i icon] [-n botname]" 1>&2
    exit 0
}

while getopts c:i:n:m: opts
do
    case $opts in
        c)
            CHANNEL=$OPTARG
            ;;
        i)
            FACEICON=$OPTARG
            ;;
        n)
            BOTNAME=$OPTARG
            ;;
        m)
            MESSAGE=$OPTARG"\n"
            ;;
        \?)
            usage_exit
            ;;
    esac
done
#slack 送信チャンネル
CHANNEL=${CHANNEL:-"@abab"}
#slack 送信名
BOTNAME=${BOTNAME:-"Concourse"}
#slack アイコン
FACEICON=${FACEICON:-":ghost:"}
#見出しとなるようなメッセージ

status=`cat ../result/status`
if test $status -eq 0  ; then
    WEBMESSAGE=":ok:\tTest Success"
else
    WEBMESSAGE=":no_entry_sign:\tTest Failed"
fi

#Incoming WebHooks送信
curl -s -S -X POST --data-urlencode "payload={\"username\": \"${BOTNAME}\", \"icon_emoji\": \"${FACEICON}\", \"text\": \"${WEBMESSAGE}\" }" ${WEBHOOKURL} >/dev/null

