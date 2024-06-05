import json
db={}
jw=[json.loads(i) for i in open("json/db.w.json","r").read().strip().split("\n")]
jr=[json.loads(i) for i in open("json/db.r.json","r").read().strip().split("\n")]
for i in jw:
	mem=i["ids"]
	for m in mem:
		if m not in db:
			db[m]=[]
		db[m].append(i["id"])
db={}
for i in jr:
	mem=i["members"]
	for mm in mem:
		m=mm[0]
		if m not in db:
			db[m]=[]
		db[m].append(i["id"])
db=[(len(v),k,) for k,v in db.items()]
db.sort()
for k,v in db:
	if k>1:
		print(k,v)
