#/usr/bin/bash

# set -xe

TASKS=$(mktemp)

grep -rn "TODO:" | sed -E 's/(.*):[0-9]:.*TODO:\s?(.*)/\1|\2/' >> $TASKS

while read task
do
    echo $task
    # ./createIssue.py "$task"
done < $TASKS

rm $TASKS
