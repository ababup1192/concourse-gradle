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
MESSAGE=${MESSAGE:-"aaaaaa"}

if [ -p /dev/stdin ] ; then
    #改行コードをslack用に変換
    cat - | tr '\n' '\\' | sed 's/\\/\\n/g'  > ${MESSAGEFILE}
else
    echo "nothing stdin"
    exit 1
fi

WEBMESSAGE='``'`cat ${MESSAGEFILE}`'``'

#Incoming WebHooks送信
curl -s -S -X POST --data-urlencode "payload={\"channel\": \"${CHANNEL}\", \"username\": \"${BOTNAME}\", \"icon_emoji\": \"${FACEICON}\", \"text\": \"${MESSAGE}${WEBMESSAGE}\" }" ${WEBHOOKURL} >/dev/null

