import json
import os



Path = os.path.dirname(os.path.realpath(__file__))
transitionsPop = json.load(open(Path+"\\..\\locations\\Transitions.jsonc"))
originalTrans = json.load(open(Path+"\\Area.json"))["Transitions"]

target = transitionsPop[0]
for v in target["children"]:
    for check in originalTrans:
        if v["name"] == check["Name"]:
            for idx,rule in enumerate(v["access_rules"]):
                if rule == "":
                    rule = f'@{check["Connections"][1]["Exit"]}'
                else:
                    rule = f'@{check["Connections"][1]["Exit"]},'+rule
                v["access_rules"][idx] = rule
transitionsPop[0] = target
file = open(Path+"\\Transitions.jsonc",'w+')
file.write(json.dumps(transitionsPop,indent=2))
file.close()