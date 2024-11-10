#!/usr/bin/env python3

import requests
import sys
import os
from pprint import pprint

assert len(sys.argv) >= 3, "You should specify repo and task"

REPO_NAME = sys.argv[1]

arg = sys.argv[2]
FILE, TODO = arg.split("|")

# print(REPO_NAME, TODO)

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

params = {
        'labels':'TODO',
        'per_page':'100',
}

r = requests.get(URL, headers=headers, params=params)

if r.status_code == 200:
    results = r.json()
    # print(results)

    issues = []

    for res in results:
        issues.append(res['title'])

    print(issues)
else:
    print(r.status_code)
    pprint(r.json())

###################
# CREATE AN ISSUE #
###################

if TODO in issues:
    exit(1)


headers = {
        "Accept": "application/vnd.github+json" ,
        "Authorization": f"Bearer {GITHUB_TOKEN}" ,
        "X-GitHub-Api-Version": "2022-11-28" ,
}

data = {
        'title': f'TODO: {TODO}',
        'body':f'{FILE}',
        'labels': ['TODO'],
}

r = requests.post(URL, headers=headers, json=data)

if r.status_code == 201:
    print(f"TODO: {TODO} -- Success!")
else:
    print(r.status_code)
    pprint(r.json())
