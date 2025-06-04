#!/usr/bin/bash

notify() {
    declare data="$(</dev/stdin)";
    echo $data
}

set -e

ENV_FILE="/home/rustam/ws/projects/useful-scripts/notify/telegram/.env"

. "$ENV_FILE"

notify
