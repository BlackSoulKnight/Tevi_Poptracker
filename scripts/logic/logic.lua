-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:

function hasAmount (code, count)
    local item = Tracker:FindObjectForCode(code)
    if (item == nil) then
        return 0
    end
    if(item.Type == "toggle") then
        return item.Active
    else 
        return item.AcquiredCount >= tonumber(count)
    end
end


function canAccessExit(exit_name)
    local entrance = TRANSITION_PAIRS[exit_name]
    local entrance_logic_path = "@Entrance Logic/"..entrance
    local loc = Tracker:FindObjectForCode(entrance_logic_path)
    --print(string.format("Resolving exit logic for '%s' accessible from entrance '%s'", exit_name, entrance))
    if Tracker:FindObjectForCode("teleporterMode").Active then
        return false
    end
    return loc.AccessibilityLevel
end


function ShowMoney()
    return not Tracker:FindObjectForCode("randomizeMoney").Active
end

function notTeleporter()
    return Tracker:FindObjectForCode("teleporterMode").Active  == 0
end

function CanFinish()
    if SLOT_DATA ~= nil then
        return goal_count <= Tracker:FindObjectForCode("gear")
    end
    -- need a implentation for singleplayer / manual tracking
    return false
end
teleporters = {}

function canUseTeleporter(id)
    id = tonumber(id)
    if teleporters[id] == nil then
        teleporters[id] = false
    end
    return teleporters[id]
end

function Chapter (count)
    local chapter = tonumber(count)
    local bossKillsRequired = 0
    local bossCounter = {}
    for i=-1, 6 do
        bossCounter[i] = 0
    end
    bossCounter[Tracker:FindObjectForCode("@Oasis/Oasis - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Oasis/Oasis - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Desert Base Entrance/Desert Base Entrance - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Desert Base Entrance/Desert Base Entrance - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Solennian Ruins/Solennian Ruins - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Solennian Ruins/Solennian Ruins - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Morose City/Morose City - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Morose City/Morose City - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Travoll Mines/Travoll Mines - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Travoll Mines/Travoll Mines - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Forest Maze boss/Forest - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Forest Maze boss/Forest - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Plague Forest/Plague Forest - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Plague Forest/Plague Forest - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Ulvosa/Ulvosa - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Ulvosa/Ulvosa - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Relicts/Relicts - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Relicts/Relicts - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Catacombs Inner/Catacombs Inner - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Catacombs Inner/Catacombs Inner - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Lab/Lab - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Lab/Lab - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@EverGarden Boss Area/EverGarden - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@EverGarden Boss Area/EverGarden - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Cloister Pre Boss/Cloister Boss - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Cloister Pre Boss/Cloister Boss - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Gallery of Mirrors East/Gallery of Mirrors East - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Gallery of Mirrors East/Gallery of Mirrors East - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Gallery of Souls Boss Area/Gallery of Souls Boss Area - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Gallery of Souls Boss Area/Gallery of Souls Boss Area - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Forgotten City/Forgotten City - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Forgotten City/Forgotten City - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Snowveil Ex/Snowveil - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Snowveil Ex/Snowveil - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Golden Hands HQ Sewer/Golden Hands HQ Sewer - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Golden Hands HQ Sewer/Golden Hands HQ Sewer - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Teleporter DreamKeeper Inside/DreamKeeper - Boss Alius/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Teleporter DreamKeeper Inside/DreamKeeper - Boss Alius/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@DreamKeeper/DreamKeeper - Boss Charon/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@DreamKeeper/DreamKeeper - Boss Charon/EVENT_BOSS").AccessibilityLevel] + 1
    bossCounter[Tracker:FindObjectForCode("@Illusion Palace Entrance/Illusion Palace Entrance - Boss/EVENT_BOSS").AccessibilityLevel] = bossCounter[Tracker:FindObjectForCode("@Illusion Palace Entrance/Illusion Palace Entrance - Boss/EVENT_BOSS").AccessibilityLevel] + 1
    
    if (chapter == 1) then
        bossKillsRequired = 1
    end
    if (chapter == 2) then
        bossKillsRequired = 3
        chapter = chapter + 1
    end
    if (chapter == 3) then
        bossKillsRequired = 5
    end
    if (chapter == 4) then
        bossKillsRequired = 7
    end
    if (chapter == 5) then
        bossKillsRequired = 10
    end
    if (chapter == 6) then
        bossKillsRequired = 13
    end
    if (chapter == 7) then
        bossKillsRequired = 16
    end
    if (chapter == 8) then
        bossKillsRequired = 20
    end
    local kills = bossCounter[AccessibilityLevel.Normal]
    if (kills >= bossKillsRequired) then
        return AccessibilityLevel.Normal
    end

    if (kills+bossCounter[AccessibilityLevel.SequenceBreak] >= bossKillsRequired) then
        return AccessibilityLevel.SequenceBreak
    end
    return 0
end

function True()
    return 1
end

function False()
    return 0
end
--TODO memine challenge count