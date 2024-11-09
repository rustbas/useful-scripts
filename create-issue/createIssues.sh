#/usr/bin/bash

# set -xe

TASKS=$(mktemp)
REPO_NAME="useful-scripts"

grep -rn "TODO:" | sed -E 's/(.*):[0-9]:.*TODO:\s?(.*)/\1|\2/' >> $TASKS

while read task
do
    ./createIssue.py "$REPO_NAME" "$task"
done < $TASKS

rm $TASKS
