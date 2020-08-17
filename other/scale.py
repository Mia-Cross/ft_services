#! /usr/bin/python3

import requests, json, time, sys
from datetime import datetime

project = PROJECT_ID

url = "https://api.intra.42.fr"
client = ""
secret = ""

access_token = requests.post(url+"/oauth/token?grant_type=client_credentials&client_id="+client+"&client_secret="+secret).json()["access_token"]

loop = 1
datas = []
print("get datas...")
while loop == 1:
	payload = {
			"page":
			{
				"size": 1
			},
			"filter":
			{
				"filled": "true"
			}
		}
	req = requests.get(url+"/v2/projects/{}/scale_teams".format(project), json=payload, headers={"Authorization": "Bearer "+access_token})
	if req.status_code == 429:
		if int(req.headers["Retry-After"]) > 10:
			print("\rWaiting: "+str(req.headers["Retry-After"])+"s")
		time.sleep(float(req.headers["Retry-After"]))
	elif req.status_code == 200:
		datas += req.json()
		if int(req.headers["X-Page"]) * int(req.headers["X-Per-Page"]) >= int(req.headers["X-Total"]):
			loop = 0
		loop = 0
	elif req.status_code == 401:
		access_token = requests.post(url+"/oauth/token?grant_type=client_credentials&client_id="+client+"&client_secret="+secret).json()["access_token"]

total = int(req.headers["X-Total"])

print("done!")

print(highlight(json.dumps(datas, indent=4), JsonLexer(), TerminalFormatter()))

for data in datas:
	questions = dict()
	for question in data["questions_with_answers"]:
		questions[question["id"]] = question["guidelines"]
	for question in sorted(questions):
		print(questions[question])
