ScootsUITweaks.frames.dungeonEvents = CreateFrame('Frame', 'ScootsUITweaks-DungeonFinder-EventFrame', UIParent)

-- Remember dropdown value across reloads

ScootsUITweaks.dungeonFinderEventHandler = function(self, event)
    if(event == 'LFG_UPDATE_RANDOM_INFO') then
        ScootsUITweaks.dungeonFinderEventDone = true
        
        if(ScootsUITweaks.savedVariables.dungeonFinderDropdownValue ~= nil) then
            if(ScootsUITweaks.savedVariables.dungeonFinderDropdownValue == 'specific') then
                LFDQueueFrame_SetType('specific')
            else
                for index = 1, GetNumRandomDungeons() do
                    local id = GetLFGRandomDungeonInfo(index)
                    
                    if(id == ScootsUITweaks.savedVariables.dungeonFinderDropdownValue) then
                        LFDQueueFrame_SetType(ScootsUITweaks.savedVariables.dungeonFinderDropdownValue)
                        break
                    end
                end
            end
        end
        
        LFDQueueFrameTypeDropDownButton_OnClick = function(self)
            ScootsUITweaks.savedVariables.dungeonFinderDropdownValue = self.value
            LFDQueueFrame_SetType(self.value)
        end
        
        ScootsUITweaks.frames.dungeonEvents:SetScript('OnEvent', nil)
    end
end

ScootsUITweaks.frames.dungeonEvents:SetScript('OnEvent', ScootsUITweaks.dungeonFinderEventHandler)

ScootsUITweaks.frames.dungeonEvents:RegisterEvent('LFG_UPDATE_RANDOM_INFO')

-- Display dungeon challenge levels in specific dungeon list

local dungeonChallengeMap = {
    -- WotLK
    [219] = 80, -- Ahn'kahet: The Old Kingdom
    [241] = 80, -- Azjol-Nerub
    [215] = 80, -- Drak'Tharon Keep
    [217] = 80, -- Gundrak
    [212] = 80, -- Halls of Lightning
    [256] = 80, -- Halls of Reflection
    [213] = 80, -- Halls of Stone
    [254] = 80, -- Pit of Saron
    [210] = 80, -- The Culling of Stratholme
    [252] = 80, -- The Forge of Souls
    [226] = 80, -- The Nexus
    [211] = 80, -- The Oculus
    [249] = 80, -- Trial of the Champion
    [242] = 80, -- Utgarde Keep
    [205] = 80, -- Utgarde Pinnacle
    [221] = 80, -- Violet Hold
    
    -- TBC
    [178] = 70, -- Auchenai Crypts
    [187] = 70, -- Blood Furnace
    [188] = 70, -- Hellfire Ramparts
    [201] = 70, -- Magister's Terrace
    [179] = 70, -- Mana-Tombs
    [180] = 70, -- Sethekk Halls
    [181] = 70, -- Shadow Labyrinth
    [189] = 70, -- Shattered Halls
    [184] = 70, -- Slave Pens
    [190] = 70, -- The Arcatraz
    [182] = 70, -- The Black Morass
    [191] = 70, -- The Botanica
    [183] = 70, -- The Escape From Durnholde
    [192] = 70, -- The mechanar
    [185] = 70, -- The Steamvault
    [186] = 70, -- Underbog
    
    -- Vanilla
    [4]   = 15, -- Ragefire Chasm
    [6]   = 19, -- Deadmines
    [1]   = 19, -- Wailing Caverns
    [8]   = 20, -- Shadowfang Keep
    [10]  = 23, -- Blackfathom Deeps
    [12]  = 24, -- Stormwind Stockade
    [16]  = 26, -- Razorfen Kraul
    [14]  = 27, -- Gnomeregan
    [18]  = 39, -- Scarlet Monastery - Graveyard
    [165] = 39, -- Scarlet Monastery - Library
    [20]  = 36, -- Razorfen Downs
    [163] = 39, -- Scarlet Monastery - Armory
    [164] = 39, -- Scarlet Monastery - Cathedral
    [22]  = 39, -- Uldaman
    [272] = 47, -- Maraudon - Purple Crystals
    [26]  = 47, -- Maraudon - Orange Crystals
    [24]  = 44, -- Zul'Farrak
    [273] = 47, -- Maraudon - Pristine Waters
    [28]  = 49, -- Sunken Temple
    [30]  = 55, -- Blackrock Depths - Prison
    [276] = 55, -- Blackrock Depths - Upper City
    [34]  = 60, -- Dire Maul - East
    [38]  = 60, -- Dire Maul - North
    [36]  = 60, -- Dire Maul - West
    [32]  = 60, -- Lower Blackrock Spire
    [2]   = 60, -- Scholomance
    [40]  = 60, -- Stratholme - Main Gate
    [274] = 60, -- Stratholme - Service Entrance
}

ScootsUITweaks.oldLFDQueueFrameSpecificListButton_SetDungeon = LFDQueueFrameSpecificListButton_SetDungeon
LFDQueueFrameSpecificListButton_SetDungeon = function(button, dungeonId, mode, subMode, ...)
    ScootsUITweaks.oldLFDQueueFrameSpecificListButton_SetDungeon(button, dungeonId, mode, subMode, ...)
    
    local levelText = dungeonChallengeMap[dungeonId]
    if(dungeonChallengeMap[dungeonId] == nil) then
        button.level:SetText('')
    else
        button.level:SetText('(' .. tostring(dungeonChallengeMap[dungeonId]) .. ')')
    end
end