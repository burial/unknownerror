local mod = CreateFrame("frame", select(2, ...), UIParent)
mod:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
mod:RegisterEvent("ADDON_LOADED")

local lastError = "No errors yet!"
local filter = {
  [ERR_INV_FULL] = true,
  [ERR_SPELL_FAILED_ALREADY_AT_FULL_MANA] = true,
  [ERR_SPELL_FAILED_ALREADY_AT_FULL_HEALTH] = true,
  [ERR_PLAYER_WRONG_FACTION] = true,
  [ERR_ARENA_TEAM_NAME_INVALID] = true,
  [ERR_TAXIPLAYERALREADYMOUNTED] = true,
}

function mod:ADDON_LOADED(addon)
  if addon == self:GetName() then
    self:UnregisterEvent("ADDON_LOADED")
    UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
    self:RegisterEvent("UI_ERROR_MESSAGE")
  end
end

function mod:UI_ERROR_MESSAGE(msg)
  if filter[msg] then
    UIErrorsFrame:AddMessage(msg, 1, 0, 0)
  else
    lastError = msg
  end
end

SLASH_UE1 = "/ue"
SLASH_UE2 = "/error"
function SlashCmdList.UE()
  UIErrorsFrame:AddMessage(lastError, 1, 0, 0)
end
