#/usr/bin/bash

# set -xe

TASKS=$(mktemp)

for f in $@
do
    grep -rn "TODO:" "$f" | sed -E 's/(.*):[0-9]:.*TODO:\s?(.*)/\1|\2/' >> $TASKS
done

while read task
do
    echo $task
done < $TASKS

rm $TASKS
