--ITEMS
Dagger              = function(count) return Tracker:ProviderCountForCode("dagger")                    >= (count or 1) end
Sable               = function(count) return Tracker:ProviderCountForCode("sable")                     >= (count or 1) end
Celia               = function(count) return Tracker:ProviderCountForCode("celia")                     >= (count or 1) end
Orbitars            = function(count) return Tracker:ProviderCountForCode("ranged")                    >= (count or 1) end
CrossBomb           = function(count) return Tracker:ProviderCountForCode("bombs")                     >= (count or 1) end
ClusterBomb         = function(count) return Tracker:ProviderCountForCode("bombThrow")                 >= (count or 1) end
BombFuel            = function(count) return Tracker:ProviderCountForCode("bombFuel")                  >= (count or 1) end
Combustible         = function(count) return Tracker:ProviderCountForCode("bombRange")                 >= (count or 1) and CrossBomb(1) end
RunningBoots        = function(count) return Tracker:ProviderCountForCode("speed")                     >= (count or 1) end
SlickBoots          = function(count) return Tracker:ProviderCountForCode("slide")                     >= (count or 1) end
SlipstreamBoots     = function(count) return Tracker:ProviderCountForCode("airDash")                   >= (count or 1) end
RabiBoots           = function(count) return Tracker:ProviderCountForCode("highJump")                  >= (count or 1) end
DoubleRabiBoots     = function(count) return Tracker:ProviderCountForCode("airJump")                   >= (count or 1) end
ParkourBoots        = function(count) return Tracker:ProviderCountForCode("wallJump")                  >= (count or 1) end
Hydrodynamo         = function(count) return Tracker:ProviderCountForCode("water")                     >= (count or 1) end
Jetpack             = function(count) return Tracker:ProviderCountForCode("jetpack")                   >= (count or 1) end
AiryPowder          = function(count) return Tracker:ProviderCountForCode("powder")                    >= (count or 1) and SlickBoots(1) end
VortexGloves        = function(count) return Tracker:ProviderCountForCode("vortex")                    >= (count or 1) and Dagger(1) end
EquilibriumRing     = function(count) return Tracker:ProviderCountForCode("ringTemp")                  >= (count or 1) end
RedTypeB            = function(count) return Tracker:ProviderCountForCode("orbS2")                     >= (count or 1) and Orbitars(2)end
RedTypeC            = function(count) return Tracker:ProviderCountForCode("orbS3")                     >= (count or 1) and Orbitars(2)end
BlueTypeB           = function(count) return Tracker:ProviderCountForCode("orbC2")                     >= (count or 1) and Orbitars(2)end
BlueTypeC           = function(count) return Tracker:ProviderCountForCode("orbC3")                     >= (count or 1) and Orbitars(2)end
TartarusVIP         = function(count) return Tracker:ProviderCountForCode("ticketHell")                >= (count or 1) end
ValhallaVIP         = function(count) return Tracker:ProviderCountForCode("ticketHeaven")              >= (count or 1) end
LibraryKey          = function(count) return Tracker:ProviderCountForCode("key")                       >= (count or 1) end
GildedLeft          = function(count) return Tracker:ProviderCountForCode("handLeft")                  >= (count or 1) end
GildedRight         = function(count) return Tracker:ProviderCountForCode("handRight")                 >= (count or 1) end
NapPillow           = function(count) return Tracker:ProviderCountForCode("pillow")                    >= (count or 1) end
OpenMorose          = function(count) return Tracker:ProviderCountForCode("openMorose")                >= (count or 1) end
RabbitJump          = function(count) return Tracker:ProviderCountForCode("rabbitJump")                >= (count or 1) end
RabbitWallJump      = function(count) return Tracker:ProviderCountForCode("rabbitWallJump")            >= (count or 1) end
Backflip            = function(count) return Tracker:ProviderCountForCode("backflip")                  >= (count or 1) end
CeilingKick         = function(count) return Tracker:ProviderCountForCode("ceilingKick")               >= (count or 1) end
HiddenPaths         = function(count) return Tracker:ProviderCountForCode("hiddenPaths")               >= (count or 1) end
EarlyDream          = function(count) return Tracker:ProviderCountForCode("earlyDream")                >= (count or 1) end
RandomItemUpgrade   = function(count) return Tracker:ProviderCountForCode("randomizeItemUpgrades")     >= (count or 1) end
VoidBomb            = function(count) return Tracker:ProviderCountForCode("voidBomb")                  >= (count or 1) end
CloudBomb           = function(count) return Tracker:ProviderCountForCode("cloudBomb")                 >= (count or 1) end
CalicoBomb          = function(count) return Tracker:ProviderCountForCode("calicoBomb")                >= (count or 1) end
TabbyBomb           = function(count) return Tracker:ProviderCountForCode("tabbyBomb")                 >= (count or 1) end
BBBomb              = function(count) return Tracker:ProviderCountForCode("bbRabbit")                    >= (count or 1) end
FireElement         = function(count) return Tracker:ProviderCountForCode("fireElement")               >= (count or 1) end
WaterElement        = function(count) return Tracker:ProviderCountForCode("waterElement")              >= (count or 1) end
EarthElement        = function(count) return Tracker:ProviderCountForCode("earthElement")              >= (count or 1) end
AirElement          = function(count) return Tracker:ProviderCountForCode("airElement")                >= (count or 1) end
LightElement        = function(count) return Tracker:ProviderCountForCode("lightElement")              >= (count or 1) end
DarkElement         = function(count) return Tracker:ProviderCountForCode("darkElement")               >= (count or 1) end

--Default Transitions
TRANSITION_PAIRS = {
    ["0000"] = "0100",
    ["0100"] = "0000",
    ["0101"] = "0201",
    ["0102"] = "0302",
    ["0105"] = "2105",
    ["0106"] = "2206",
    ["0107"] = "0507",
    ["0201"] = "0101",
    ["0300"] = "0400",
    ["0301"] = "0501",
    ["0302"] = "0102",
    ["0303"] = "0603",
    ["0400"] = "0300",
    ["0401"] = "0701",
    ["0404"] = "1304",
    ["0408"] = "0908",
    ["0409"] = "0509",
    ["0500"] = "1700",
    ["0501"] = "0301",
    ["0503"] = "1703",
    ["0507"] = "0107",
    ["0509"] = "0409",
    ["0600"] = "2100",
    ["0603"] = "0303",
    ["0605"] = "0705",
    ["0700"] = "0900",
    ["0701"] = "0401",
    ["0704"] = "2404",
    ["0705"] = "0605",
    ["0805"] = "0905",
    ["0806"] = "2706",
    ["0900"] = "0700",
    ["0901"] = "1001",
    ["0902"] = "1102",
    ["0903"] = "2803",
    ["0904"] = "1004",
    ["0905"] = "0805",
    ["0906"] = "2406",
    ["0908"] = "0408",
    ["1001"] = "0901",
    ["1004"] = "0904",
    ["1102"] = "0902",
    ["1202"] = "1402",
    ["1204"] = "1604",
    ["1205"] = "1805",
    ["1300"] = "1400",
    ["1301"] = "2801",
    ["1303"] = "1403",
    ["1304"] = "0404",
    ["1307"] = "2707",
    ["1400"] = "1300",
    ["1402"] = "1202",
    ["1403"] = "1303",
    ["1410"] = "2510",
    ["1502"] = "1702",
    ["1503"] = "2503",
    ["1600"] = "1800",
    ["1604"] = "1204",
    ["1700"] = "0500",
    ["1701"] = "2301",
    ["1702"] = "1502",
    ["1703"] = "0503",
    ["1800"] = "1600",
    ["1801"] = "1901",
    ["1805"] = "1205",
    ["1900"] = "2900",
    ["1901"] = "1801",
    ["2001"] = "2101",
    ["2003"] = "2902",
    ["2008"] = "2608",
    ["2100"] = "0600",
    ["2101"] = "2001",
    ["2105"] = "0105",
    ["2206"] = "0106",
    ["2301"] = "1701",
    ["2404"] = "0704",
    ["2406"] = "0906",
    ["2503"] = "1503",
    ["2510"] = "1410",
    ["2608"] = "2008",
    ["2706"] = "0806",
    ["2707"] = "1307",
    ["2801"] = "1301",
    ["2803"] = "0903",
    ["2900"] = "1900",
    ["2902"] = "2003",
}


function hasFire()
	
    local accessibilityLevel = math.max(Tracker:FindObjectForCode("@Solennian Ruins/Solennian Ruins - Fire/EVENT_Fire").AccessibilityLevel,
    Tracker:FindObjectForCode("@Travoll Mines/Travoll Mines - Fire/EVENT_Fire").AccessibilityLevel,
    Tracker:FindObjectForCode("@Travoll Mines/Travoll Mines - Fire/EVENT_Fire").AccessibilityLevel
    )
    
    if accessibilityLevel >= AccessibilityLevel.Normal then
        local obj = Tracker:FindObjectForCode("fireElement")
        obj.Active = true
    end
end
function hasWater()
	
    local accessibilityLevel = math.max(
    Tracker:FindObjectForCode("@Verdazure Sea West/Verdazure Sea - Water West/EVENT_Water").AccessibilityLevel,
    Tracker:FindObjectForCode("@Verdazure Sea East/Verdazure Sea - Water/EVENT_Water").AccessibilityLevel
    )
    
    if accessibilityLevel >= AccessibilityLevel.Normal then
        local obj = Tracker:FindObjectForCode("waterElement")
        obj.Active = true
    end
end
function hasEarth()
	
    local accessibilityLevel = math.max(
    Tracker:FindObjectForCode("@Gloamwood Middle/Gloamwood Upper - Earth/EVENT_Earth").AccessibilityLevel,
    Tracker:FindObjectForCode("@Gloamwood Right/Ulskan Village Area - Earth/EVENT_Earth").AccessibilityLevel
    )
    
    if accessibilityLevel >= AccessibilityLevel.Normal then
        local obj = Tracker:FindObjectForCode("earthElement")
        obj.Active = true
    end
end
function hasAir()
	
    local accessibilityLevel = math.max(
    Tracker:FindObjectForCode("@Snowveil/Snowveil - Air/EVENT_Air").AccessibilityLevel,
    Tracker:FindObjectForCode("@Snowveil Above HQ/Snowveil Above HQ - Air/EVENT_Air").AccessibilityLevel,
    Tracker:FindObjectForCode("@Heavens Valley Snow Route Low/Heavens Valley Snow Route Low - Air/EVENT_Air").AccessibilityLevel
    )
    if accessibilityLevel >= AccessibilityLevel.Normal then
        local obj = Tracker:FindObjectForCode("airElement")
        obj.Active = true
    end
end
function hasWater()
	
    local accessibilityLevel = math.max(
    Tracker:FindObjectForCode("@Verdazure Sea West/Verdazure Sea - Water West/EVENT_Water").AccessibilityLevel,
    Tracker:FindObjectForCode("@Verdazure Sea East/Verdazure Sea - Water/EVENT_Water").AccessibilityLevel
    )
    if accessibilityLevel >= AccessibilityLevel.Normal then
        local obj = Tracker:FindObjectForCode("fireElement")
        obj.Active = true
    end
end
function hasLight()
	
    local accessibilityLevel = math.max(
    Tracker:FindObjectForCode("@Heavens Valley West/Heavens Valley West - Light/EVENT_Light").AccessibilityLevel,
    Tracker:FindObjectForCode("@Valhalla Breath West/Valhalla Breath West - Light/EVENT_Light").AccessibilityLevel,
    Tracker:FindObjectForCode("@Heavens Valley Snow Route Low/Heavens Valley Snow Route Low - Light/EVENT_Light").AccessibilityLevel
    )
    if accessibilityLevel >= AccessibilityLevel.Normal then
        local obj = Tracker:FindObjectForCode("lightElement")
        obj.Active = true
    end

end
function hasDark()
	
    local accessibilityLevel = math.max(
    Tracker:FindObjectForCode("@Pre Swamp/Swamp Entrance - Dark/EVENT_Dark").AccessibilityLevel,
    Tracker:FindObjectForCode("@Swamp/Swamp - Dark/EVENT_Dark").AccessibilityLevel,
    Tracker:FindObjectForCode("@Blushwood/Blushwood - Dark/EVENT_Dark").AccessibilityLevel,
    Tracker:FindObjectForCode("@Verdazure Swamp/Verdazure Swamp - Dark/EVENT_Dark").AccessibilityLevel
    )
    if accessibilityLevel >= AccessibilityLevel.Normal then
        local obj = Tracker:FindObjectForCode("darkElement")
        obj.Active = true
    end
end


canBombThrow = function() return ClusterBomb() end
canAirSlide = function() return AiryPowder() and SlickBoots() end
canBombFuel = function() return BombFuel() and (CrossBomb() or ClusterBomb()) end
canVortex = function() return VortexGloves() and Dagger() end
canBombLengthExtend = function() return Combustible() and CrossBomb() end

canChargeShot = function() return Orbitars(2) end

canBreakMoney = function() return CrossBomb() or Dagger() end

canUpgradeCompass = function() return true end
--needs to reach beat 3 memine challenge

--currently needs all movement, subject to change
numCompletedMemine = function() return true end
--    local num = 0
--    if (LOCATIONS["Memine Blushwood Sliding - Rainbow Bunny Potion"]) then
--        num+=1
--    end
--    if (LOCATIONS["Memine Forest - Rainbow Bunny Potion"]) then
--        num+=1
--    end
--    if (LOCATIONS["Memine Tartarus - Rainbow Bunny Potion"]) then
--        num+=1
--    end
--    if (LOCATIONS["Memine Valhalla Breath West Extended - Rainbow Bunny Potion"]) then
--        num+=1
--    end
--    if (LOCATIONS["Memine Ana Thema - Rainbow Bunny Potion #1"]) then
--        num+=1
--    end
--    if (LOCATIONS["Memine Completion - Rainbow Bunny Potion"]) then
--        num+=1
--    end
--    return num
--end


canUpgradeItems = function() return (not RandomItemUpgrade() or hasAllMovement()) and CrossBomb() end

canUpgradeOrbType = function() return hasAllMovement() and CrossBomb() end

canUpgradeCore = function() return hasAllMovement() and CrossBomb() and canBombThrow() and Combustible() end

hasAllMovement = function() return RabiBoots() and DoubleRabiBoots() and ParkourBoots() and SlickBoots() and Hydrodynamo() and SlipstreamBoots() and Jetpack() end

canUseSpinnerBash = function() return Dagger() end

canFinishMemine = function() return CrossBomb() and canChargeShot() and hasAllMovement() end

canVoidBomb = function() return VoidBomb() and hasFire() end

canCloudBomb = function() return CloudBomb() and hasFire() and hasLight() end

canCalicoBomb = function() return CalicoBomb() and hasWater() and hasEarth() end

canTabbyBomb = function() return TabbyBomb() and hasDark() and hasEarth() end

canUseVenaBomb = function () return canVoidBomb() or canCloudBomb() or canCalicoBomb() or canTabbyBomb() end

canUseFastItem = function () return BBBomb() or canUseVenaBomb() end

canRabbitJump = function() return RabbitJump() and canUseFastItem() end

canRabbitWallJump = function() return RabbitWallJump() and canUseFastItem() and ParkourBoots() end

canEarlyDream = function() return EarlyDream() and Dagger() end

canBackflip = function() return Backflip() and Dagger() end

function airOrSlide() 
    return SlickBoots() or SlipstreamBoots()
end