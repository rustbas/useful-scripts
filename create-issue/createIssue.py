#!/usr/bin/env python3

import requests
import sys
import os
from pprint import pprint

assert len(sys.argv) >= 3, "You should specify repo and task"

REPO_NAME = sys.argv[1]
TODO = sys.argv[2]

print(REPO_NAME, TODO)

###################
# LIST ALL ISSUES #
###################

if os.path.isfile(os.path.expanduser("~/.env")):
    GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')
    GITHUB_USER = os.environ.get('GITHUB_USER')

URL = f"https://api.github.com/repos/{GITHUB_USER}/{REPO_NAME}/issues"

headers = {
        "Accept": "application/vnd.github+json" ,
        "Authorization": f"Bearer {GITHUB_TOKEN}" ,
        "X-GitHub-Api-Version": "2022-11-28" ,
}

r = requests.get(URL, headers=headers)

if r.status_code == 200:
    pprint(r.json())
else:
    print(r.status_code)
    pprint(r.json())
