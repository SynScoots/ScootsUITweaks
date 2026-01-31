ScootsUITweaks_itemtracker_init = function()
    if((CMCGetMultiClassEnabled() or 1) == 2) then
        ScootsUITweaks.frames.itemTrackerEvents = CreateFrame('Frame', 'ScootsUITweaks-ItemTracker-EventFrame', UIParent)
        local hookedFrames = {}
        
        ScootsUITweaks.frames.itemTrackerEvents:SetScript('OnUpdate', function()
            local missingFrame = false
            
            for i = 1, 20 do
                local frameName = 'ItemHuntFrameItem' .. tostring(i)
                local frame = _G[frameName]
                
                if(frame == nil) then
                    missingFrame = true
                elseif(hookedFrames[frameName] == nil) then
                    local oldClickEvent = frame:GetScript('OnClick')
                    
                    frame:SetScript('OnClick', function(...)
                        if(IsAltKeyDown()) then
                            if(frame.cele and frame.cele.entry) then
                                SendChatMessage('.coerceitem ' .. tostring(frame.cele.entry), 'SAY')
                            end
                        else
                            oldClickEvent(...)
                        end
                    end)
                    
                    hookedFrames[frameName] = true
                end
            end
            
            if(missingFrame == false) then
                ScootsUITweaks.frames.itemTrackerEvents:SetScript('OnUpdate', nil)
            end
        end)
    end
end

SynastriaSafeInvoke('ScootsUITweaks_itemtracker_init')