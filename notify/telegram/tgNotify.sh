#!/usr/bin/bash

notify() {
    declare raw_data="$(</dev/stdin)";
    echo $raw_data
}

DATA=`notify`

while getopts "n" OPT; do
    case $OPT in
        n)
            DATA="Empty command"
            ;;
        \?)
            exit 1
            ;;
    esac
done

set -e

ENV_FILE="/home/rustam/ws/projects/useful-scripts/notify/telegram/.env"

[ -f "$ENV_FILE" ] && source "$ENV_FILE"


[ -z "$TG_TOKEN" ]  && echo "Provide a TG_TOKEN variable!"  1>&2 && exit 1
[ -z "$CHAT_ID" ]   && echo "Provide a CHAT_ID variable!"   1>&2 && exit 1
[ -z "$THREAD_ID" ] && echo "Provide a THREAD_ID variable!" 1>&2 && exit 1

CURL="curl"
CURL_URL="https://api.telegram.org/bot$TG_TOKEN/sendMessage"
CURL_MSG="""
_Notification from command line_

\`\`\`
$DATA
\`\`\`
"""

$CURL -X POST \
      -s \
      -o /dev/null \
      -H 'Content-Type: application/json' \
      -d "{
            \"chat_id\": $CHAT_ID, \
            \"message_thread_id\":\"$THREAD_ID\", \
            \"text\": \"$CURL_MSG\", \
            \"disable_notification\": true, \
            \"parse_mode\":\"MarkdownV2\"}" \
      $CURL_URL
