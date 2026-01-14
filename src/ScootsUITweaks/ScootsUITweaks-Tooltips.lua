ScootsUITweaks_tooltip_init = function()
    GameTooltip:HookScript('OnTooltipSetItem', function(self)
        local _, itemLink = self:GetItem()
        
        if(itemLink) then
            local itemId = CustomExtractItemId(itemLink)
            
            -- Prestiged characters can see attunement progress on non-optimal items
            if((CMCGetMultiClassEnabled() or 1) == 2 and GetCustomGameData(29, 1500) > 0) then
                local attuneAtAll = IsAttunableBySomeone(itemId)
            
                if(CanAttuneItemHelper(itemId) <= 0 and attuneAtAll ~= nil and attuneAtAll ~= 0) then
                    local soulbound = false
                    
                    for lineIndex = 2, self:NumLines() do
                        local leftLine = _G[self:GetName() .. 'TextLeft' .. lineIndex]
                        
                        if(leftLine) then
                            local text = leftLine:GetText()
                            
                            if(text == ITEM_SOULBOUND) then
                                soulbound = true
                                break
                            end
                        end
                    end

                    if(soulbound == false) then
                        local goldQuestion = '|TInterface\\GossipFrame\\ActiveQuestIcon:16:16|t'
                        local blueQuestion = '|TInterface\\GossipFrame\\DailyActiveQuestIcon:16:16|t'
                        local blueExclaim = '|TInterface\\GossipFrame\\DailyQuestIcon:16:16|t'
                        
                        local progress = GetItemLinkAttuneProgress(itemLink)
                        
                        if(progress < 100) then
                            local attunedLevel = GetItemAttuneForge(itemId)
                            local itemForgeLevel = GetItemLinkTitanforge(itemLink)
                            
                            if(attunedLevel < 0) then
                                icon = goldQuestion
                            elseif(attunedLevel < itemForgeLevel) then
                                icon = blueExclaim
                            else
                                icon = blueQuestion
                            end
                            
                            local zero = {1.00, 0.40, 0.40}
                            local low =  {0.85, 0.85, 0.40}
                            local full = {0.40, 0.90, 0.40}
                            
                            local r, g, b
                            
                            if(progress == 0) then
                                r, g, b = zero[1], zero[2], zero[3]
                            else
                                r = low[1] + ((full[1] - low[1]) * (progress / 100))
                                g = low[2] + ((full[2] - low[2]) * (progress / 100))
                                b = low[3] + ((full[3] - low[3]) * (progress / 100))
                                
                                progress = string.format('%.2f', math.floor((progress * 100) + 0.5) / 100)
                            end
                            
                            self:AddDoubleLine(icon .. ' Attuned XP', progress .. '%', 0.6, 0.6, 1, r, g, b)
                        end
                    end
                end
            end
            
            -- Display item source for starter equipment
            local map = {
                [39]    = 'Human Warrior',
                [44]    = 'Human Paladin',
                [48]    = 'Human Rogue',
                [52]    = 'Human Priest',
                [56]    = 'Human Mage',
                [57]    = 'Human Warlock',
                [120]   = 'Undead Rogue',
                [139]   = 'Undead Warrior',
                [147]   = 'Dwarf Hunter',
                [153]   = 'Orc Shaman',
                [1395]  = 'Human Mage',
                [1396]  = 'Human Warlock',
                [2362]  = 'Orc Shaman',
                [6098]  = 'Human Priest',
                [6118]  = 'Dwarf Paladin',
                [6119]  = 'Night Elf Priest',
                [6121]  = 'Night Elf Warrior',
                [6123]  = 'Night Elf Druid',
                [6124]  = 'Night Elf Druid',
                [6126]  = 'Orc Hunter',
                [6129]  = 'Undead Warlock',
                [6135]  = 'Troll Shaman',
                [6137]  = 'Troll Rogue',
                [6139]  = 'Tauren Druid',
                [6140]  = 'Undead Mage',
                [6144]  = 'Undead Priest',
                [20891] = 'Blood Elf Priest',
                [20892] = 'Blood Elf Warlock',
                [20893] = 'Blood Elf Mage',
                [20894] = 'Blood Elf Mage',
                [20896] = 'Blood Elf Rogue',
                [20898] = 'Blood Elf Rogue',
                [20899] = 'Blood Elf Hunter',
                [20900] = 'Blood Elf Hunter',
                [23322] = 'Draenei Priest',
                [23344] = 'Draenei Shaman',
                [23474] = 'Draenei Warrior',
                [23477] = 'Draenei Paladin',
                [23478] = 'Draenei Mage',
                [23479] = 'Draenei Mage',
                [24145] = 'Blood Elf Paladin',
                [24146] = 'Blood Elf Paladin',
            }
            
            if(map[itemId] ~= nil) then
                self:AddLine('Available on a ' .. map[itemId], 0.6, 0.98, 0.6, true)
            end
        end
    end)
end

SynastriaSafeInvoke('ScootsUITweaks_tooltip_init')