-- Prestiged characters can see attunement progress on non-optimal items

ScootsUITweaks_tooltip_init = function()
    GameTooltip:HookScript('OnTooltipSetItem', function(self)
        if(
            CMCGetMultiClassEnabled
        and GetCustomGameData
        and CustomExtractItemId
        and IsAttunableBySomeone
        and CanAttuneItemHelper
        and GetItemAttuneForge
        and GetItemLinkTitanforge
        and GetItemLinkAttuneProgress
        ) then
            if((CMCGetMultiClassEnabled() or 1) == 2 and GetCustomGameData(29, 1500) > 0) then
                local _, itemLink = self:GetItem()
                
                if(itemLink) then
                    local itemId = CustomExtractItemId(itemLink)
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
                            
                            local attunedLevel = GetItemAttuneForge(itemId)
                            local itemForgeLevel = GetItemLinkTitanforge(itemLink)
                            
                            if(attunedLevel < 0) then
                                icon = goldQuestion
                            elseif(attunedLevel < itemForgeLevel) then
                                icon = blueExclaim
                            else
                                icon = blueQuestion
                            end
                            
                            local progress = GetItemLinkAttuneProgress(itemLink)
                            local zero = {1.00, 0.40, 0.40}
                            local low =  {0.85, 0.85, 0.40}
                            local full = {0.40, 0.90, 0.40}
                            
                            local r, g, b
                            
                            if(progress == 0) then
                                self:AddLine('zero')
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
        end
    end)
end

ScootsUITweaks_tooltip_init()
--SynastriaSafeInvoke('ScootsUITweaks_tooltip_init')