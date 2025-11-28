import json
import os
from python_files.knowMaps import knownMapLocation
from python_files.logicParser import parse_expression_logic
import zipfile

Path = os.path.dirname(os.path.realpath(__file__))

TeviToApNames = json.load(open(Path+"\\resource\\ItemToReal.json"))
ApNamesToTevi = {name: data for name, data in TeviToApNames.items()}
ApNames = [name for name in TeviToApNames.values()]

regionsIds = {}
regionLocations = {}
currentRegionId = 0
PoptrackerList = []
customLocation = {}


RandomizerLocationList = json.load(open(Path+"\\resource\\Location.json"))
RandomizerAreaList = json.load(open(Path+"\\resource\\Area.json"))
RandomizerLocationGroupNames = json.load(open(Path+"\\resource\\RoomGroupNames.json"))
RandomizerLocationList += json.load(open(Path+"\\resource\\UpgradeResourceLocation.json"))

del RandomizerAreaList["Transitions"]

def setAccessRule(rule):
    logic = []
    for v in rule:
        
        t = parse_expression_logic(v["Method"])
        for log in t:
            if t == "$True" or t == "":
                continue

        logic += t
    return logic

def addMapAccessRule(rule):
    logic = []
    for v in rule:
        t = str(parse_expression_logic(v["Method"]))
        logic += [t]

    return logic

for v in PoptrackerList:
    v["access_rules"] = []
    for ve in v["children"]:
        ve["access_rules"] = []

extra = open(Path+"\\..\\scripts\\autotracking\\location_mapping.lua",'w+')
## start stuff
extra.write("BASE_LOCATION_ID = 44966541000\n LOCATION_MAPPING = {\n")


utTracker = open(Path+"\\UT_Tracker_Mapping.txt",'w+')

baseID = 44966541000


locationList = {}
locationNameList = {}
for val in RandomizerLocationList:
    if not val["Location"] in regionsIds:
        regionTemplate = {
            "name": val["Location"],
            "access_rules": [],
            "children": []
        }
        regionsIds[val["Location"]] = currentRegionId
        currentRegionId +=1
        PoptrackerList.append(regionTemplate)
    locationName = val["LocationName"]
    itemName = val["Itemname"]
    if val["Itemname"] in ApNamesToTevi:
        itemName = ApNamesToTevi[itemName]

    locTemplate = {
        "name": locationName,
        "access_rules": [],
        "sections": [{
                    "name": itemName,
                    "item_count": 1,
                    "access_rules":setAccessRule(val["Requirement"])
                    }],
        "map_locations": []
      }   
    for v in val["LocationRegion"]:
        locdata = knownMapLocation[v["Area"]]
        locTemplate["map_locations"]+=[{
            "map": locdata["areaName"],
            "x": locdata["StartRoom"]["PixelX"]+((v["X"] - locdata["StartRoom"]["X"])*48)+24,
            "y": locdata["StartRoom"]["PixelY"]+((v["Y"] - locdata["StartRoom"]["Y"])*48)+24
          }]
        
        locationCode = v["Area"]*10000+v["X"]*100+v["Y"]
        if "EVENT" in itemName:
            continue
        if locationCode in locationList:
            locationList[locationCode] += locTemplate["sections"].copy()  
            locationNameList[locationCode] += [locTemplate["name"]]
        else:
            locationList[locationCode] = locTemplate["sections"].copy()
            locationNameList[locationCode] = [locTemplate["name"]]
        if str(locationCode) in RandomizerLocationGroupNames:
            locTemplate["name"] = RandomizerLocationGroupNames[str(locationCode)]["name"]
            locationName = RandomizerLocationGroupNames[str(locationCode)]["name"]

        

    
    if "EVENT" in val["Itemname"]:
        for v in locTemplate["map_locations"]:
            v["force_invisibility_rules"] = ["$True"]


    if len(locTemplate["access_rules"]) == 1 and locTemplate["access_rules"][0] == "$True":
        locTemplate["access_rules"] = []

    found = False

    for location in PoptrackerList[regionsIds[val["Location"]]]["children"]:
        if location["name"] == locationName:
            location["access_rules"] = locTemplate["access_rules"]
            for section in location["sections"]:
                if section["name"] == itemName:
                    found = True
                    break
            if not found:
                location["sections"] += [{
                    "name": itemName,
                    "item_count": 1,
                    "access_rules":setAccessRule(val["Requirement"])
                    }]
            found = True
            if len(locTemplate["access_rules"]) == 1 and locTemplate["access_rules"][0] == "$True":
                locTemplate["access_rules"] = []
    if not found:
        PoptrackerList[regionsIds[val["Location"]]]["children"].append(locTemplate)
    
    extra.write(f"\t[{baseID}] ="+"{{"+f'"@{val["Location"]}/{locationName}/{itemName}"'+"}},\n")
    utTracker.write(f'"{locationName}/{itemName}":{baseID},\n')
    baseID += 1

change = False
for k,v in locationList.items():
    if len(v) > 1:
        if str(k) not in RandomizerLocationGroupNames:
            print(locationNameList[k])
            print("\n")
            RandomizerLocationGroupNames[str(k)] = {"name":input("Enter Groupname: "),"sections":v}
            change = True
        else:
            RandomizerLocationGroupNames[str(k)]["sections"]=v

if change:
    groupNameFile = open(Path+"\\resource\\RoomGroupNames.json",'w+')
    groupNameFile.write(json.dumps(RandomizerLocationGroupNames,indent=4))
    groupNameFile.close()

utTracker.close()
extra.seek(extra.tell() - 2, os.SEEK_SET)
extra.write("\n}")
extra.close()
for k,v in RandomizerAreaList.items():
    for area in v:
        for con in area["Connections"]:
            if con["Exit"] == "":
                continue
            logic = setAccessRule([{"Method":con["Method"]}])
            newLogic = []
            for log in logic:
                if log == "$True":
                    logic[0] = []
                if con["Exit"].isdigit():
                    if len(logic[0]) > 0:
                        newLogic += [f"@Exit Logic/{con['Exit']},{log}"]
                    else:
                        newLogic += [f"@Exit Logic/{con['Exit']}"]
                else:
                    if len(logic[0])> 0:
                        newLogic += [f"@{area['Name']},{log}"]
                    else:
                        newLogic += [f"@{area['Name']}" ]
            logic = newLogic
            if con["Exit"].isdigit():
                if not area["Name"] in regionsIds:
                    regionTemplate = {
                        "name": area['Name'],
                        "clear_as_group": False,
                        "access_rules": logic,
                        "children": []
                    }
                    regionsIds[area['Name']] = currentRegionId
                    currentRegionId +=1
                    PoptrackerList.append(regionTemplate)                      
                else:
                    PoptrackerList[regionsIds[area["Name"]]]["access_rules"] += logic
            else:
                if not con["Exit"] in regionsIds:
                    regionTemplate = {
                        "name": con['Exit'],
                        "clear_as_group": False,
                        "access_rules": logic,
                        "children": []
                    }
                    regionsIds[con['Exit']] = currentRegionId
                    currentRegionId +=1
                    PoptrackerList.append(regionTemplate)                    


                else:
                    PoptrackerList[regionsIds[con["Exit"]]]["access_rules"] += logic
PoptrackerList.append({
    "name": "TeleportHub",
    "access_rules": [
      "teleporterMode"
    ],
    "children": []
  })

PoptrackerList[regionsIds["Thanatara Canyon"]]["access_rules"] = []
file = open(Path+"\\..\\locations\\locations.jsonc",'w+')
file.write(json.dumps(PoptrackerList,indent=2))
file.close()
print("finished")
#import copyPosition

    