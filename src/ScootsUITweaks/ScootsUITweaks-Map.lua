-- Button to turn pins into TomTom waypoints

if(IsAddOnLoaded('TomTom')) then
    ScootsUITweaks.convertPinsToWaypoints = function()
        local count = Custom_GetMapMarker()
        local limit = 500
        
        for pinIndex = 1, count do
            if(pinIndex >= limit) then
                break
            end
            
            local objKey, x, y = Custom_GetMapMarker(pinIndex)
            
            TomTom:AddWaypoint(100 * x, 100 * y, ScootsUITweaks.getKeyName(objKey))
        end
    end

    ScootsUITweaks.addButtonToFindThingFrame = function()
        if(_G['WorldMapFrame'] ~= nil and _G['WorldMapFrame']:IsVisible()) then
            if(_G['FindThingFrame'] ~= nil and _G['FindThingFrame']:IsVisible()) then
                ScootsUITweaks.frames.waypointButton = CreateFrame('Button', 'ScootsUITweaks-WaypointButton', _G['FindThingFrame'], 'UIPanelButtonTemplate')
                ScootsUITweaks.frames.waypointButton:SetWidth(160)
                ScootsUITweaks.frames.waypointButton:SetHeight(20)
                ScootsUITweaks.frames.waypointButton:SetText('Zone Pins as Waypoints')
                ScootsUITweaks.frames.waypointButton:SetPoint('BOTTOM', _G['FindThingFrame'], 'BOTTOM', -22, 82)
                
                ScootsUITweaks.frames.waypointButton:SetScript('OnClick', ScootsUITweaks.convertPinsToWaypoints)
                
                if(GetCurrentMapZone() == 0) then
                    ScootsUITweaks.frames.waypointButton:Hide()
                end
            end
        end
    end

    ScootsUITweaks.mapEventHandler = function(self, event)
        if(event == 'WORLD_MAP_UPDATE') then
            if(ScootsUITweaks.frames.waypointButton == nil) then
                ScootsUITweaks.addButtonToFindThingFrame()
            else
                if(GetCurrentMapZone() == 0) then
                    ScootsUITweaks.frames.waypointButton:Hide()
                else
                    ScootsUITweaks.frames.waypointButton:Show()
                end
            end
        end
    end

    ScootsUITweaks.getKeyName = function(key)
        local typeid = bit.rshift(key, 24)
        local name = nil
        
        if(typeid == 3) then
            name = GetItemInfoCustom(bit.band(key, 0x00FFFFFF))
        else
            local _, oname = Custom_GetObjLoc(typeid, bit.band(key, 0x00FFFFFF))
            name = oname
        end
        
        if(not name or string.len(name) == 0) then
            name = '?'
        end
        
        return name
    end

    ScootsUITweaks_map_init = function()
        ScootsUITweaks.frames.events:HookScript('OnEvent', ScootsUITweaks.mapEventHandler)

        ScootsUITweaks.frames.events:RegisterEvent('WORLD_MAP_UPDATE')
    end

    --SynastriaSafeInvoke('ScootsUITweaks_map_init')
    ScootsUITweaks_map_init()
    
    -- Directly calling ScootsUITweaks_map_init here works, but is technically introducing a race condition.
end