export SLASH_UE1, SLASH_UE2

mod = CreateFrame("frame", select(1, ...), UIParent)
mod\SetScript("OnEvent", (event, ...) => self[event](self, ...))
mod\RegisterEvent("ADDON_LOADED")

lastError = nil
filter =
  [_G.ERR_INV_FULL]: true
  [_G.ERR_SPELL_FAILED_ALREADY_AT_FULL_MANA]: true
  [_G.ERR_SPELL_FAILED_ALREADY_AT_FULL_HEALTH]: true
  [_G.ERR_PLAYER_WRONG_FACTION]: true
  [_G.ERR_ARENA_TEAM_NAME_INVALID]: true
  [_G.ERR_TAXIPLAYERALREADYMOUNTED]: true

mod.ADDON_LOADED = (addon) =>
  if addon == self\GetName!
    self\UnregisterEvent("ADDON_LOADED")
    self\RegisterEvent("UI_ERROR_MESSAGE")
    UIErrorsFrame\UnregisterEvent("UI_ERROR_MESSAGE")
    true

mod.UI_ERROR_MESSAGE = (message) =>
  if filter[msg]
    UIErrorsFrame\AddMessage(msg, 1, 0, 0)
    true
  else
    lastError = msg
    false

SLASH_UE1 = "/ue"
SLASH_UE2 = "/error"
SlashCmdList.UE = ->
  UIErrorsFrame\AddMessage(lastError, 1, 1, 1)
  true
