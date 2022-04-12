#!/usr/bin/python


# Script to get from a Github PR to Testray results
# 
# Requires "requests" module (pip install requests)
#
# Run with ./testrayPR.py {GITHUB_PR_URL}

import json
import re
import requests
import sys

def getTestrayLinks(url):
    login = ("sir.testalot@liferay.com", "TestyourmighT")

    routineIds = [84095177, 84095178, 38582544, 38602290, 439299171, 439299172, 849929038, 849929056]

    url_stripped = re.sub("<[^<]+?>", "", url)

    pull = url_stripped.split("#")[0]
    number = pull.split("/")[-1]

    links = {}

    for rout in routineIds:
        parameters = {"testrayRoutineId": rout, "delta": 200}

        result = requests.get(
            "https://testray.liferay.com/home/-/testray/builds.json",
            auth=login,
            params=parameters)

        for r in result.json()["data"]:
            if "PR#%s " % (number) in r["name"]:
                links[r["name"]] = r["htmlURL"]

    return links

def displayTestrayLinks(link):
    try:
        tr = getTestrayLinks(link)

        if tr:
            tr_message = "Testray results for this PR:\n\n" \
                + "\n\n".join(["%s\n%s" % (k, v)
                               for k, v in tr.items()])
            return tr_message
            
    except Exception as e:
        print(e)

if __name__ == "__main__":
    try:
        link = sys.argv[1]
    except:
        print("Please provide a github pull request URL")
        exit()

    result = displayTestrayLinks(link)

    if result:
        print("\n" + result)
    else:
        print("Could not find any testray links for that URL")
