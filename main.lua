local mod = CreateFrame("frame", select(1, ...), UIParent)
mod:SetScript("OnEvent", function(self, event, ...)
  return self[event](self, ...)
end)
mod:RegisterEvent("ADDON_LOADED")
local lastError = nil
local filter = {
  [_G.ERR_INV_FULL] = true,
  [_G.ERR_SPELL_FAILED_ALREADY_AT_FULL_MANA] = true,
  [_G.ERR_SPELL_FAILED_ALREADY_AT_FULL_HEALTH] = true,
  [_G.ERR_PLAYER_WRONG_FACTION] = true,
  [_G.ERR_ARENA_TEAM_NAME_INVALID] = true,
  [_G.ERR_TAXIPLAYERALREADYMOUNTED] = true
}
mod.ADDON_LOADED = function(self, addon)
  if addon == self:GetName() then
    self:UnregisterEvent("ADDON_LOADED")
    self:RegisterEvent("UI_ERROR_MESSAGE")
    UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
    return true
  end
end
mod.UI_ERROR_MESSAGE = function(self, message)
  if filter[msg] then
    UIErrorsFrame:AddMessage(msg, 1, 0, 0)
    return true
  else
    lastError = msg
    return false
  end
end
SLASH_UE1 = "/ue"
SLASH_UE2 = "/error"
SlashCmdList.UE = function()
  UIErrorsFrame:AddMessage(lastError, 1, 1, 1)
  return true
end
