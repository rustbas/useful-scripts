#/usr/bin/bash

# set -xe

grep -rn "TODO:" | sed -E 's/(.*):[0-9]:.*TODO:\s?(.*)/\1|\2/'
