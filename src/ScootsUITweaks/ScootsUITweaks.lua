ScootsUITweaks = {
    ['version'] = '1.0.0',
    ['frames'] = {
        ['events'] = CreateFrame('Frame', 'ScootsUITweaks-EventFrame', UIParent),
    },
    ['savedVariables'] = {},
}

ScootsUITweaks.frames.events:SetScript('OnEvent', function(self, event)
    if(event == 'ADDON_LOADED') then
        if(_G['SCOOTS_UI_TWEAKS'] ~= nil) then
            ScootsUITweaks.savedVariables = _G['SCOOTS_UI_TWEAKS']
        end
    elseif(event == 'PLAYER_LOGOUT') then
        _G['SCOOTS_UI_TWEAKS'] = ScootsUITweaks.savedVariables
    end
end)

ScootsUITweaks.frames.events:SetScript('OnUpdate', function() end)

ScootsUITweaks.frames.events:RegisterEvent('ADDON_LOADED')
ScootsUITweaks.frames.events:RegisterEvent('PLAYER_LOGOUT')