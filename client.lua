local isUiOpen = false
local userTurnedOff = false

Citizen.CreateThread(function()
    local previousState = false

    while true do
        Citizen.Wait(100)

        local isMapOrUiActive = IsRadarHidden() or IsPauseMenuActive()

        if isMapOrUiActive ~= previousState then
          previousState = isMapOrUiActive
          if not userTurnedOff then
              showWM(not isMapOrUiActive)
          end
      end
  end
end)

function showWM(display)
  local success, err = pcall(function()
      SendNUIMessage({
          type = 'DisplayWM',
          visible = display,
          position = config.position -- Pass the position from the config
      })
  end)
  if not success then
      print("^1Error sending NUI message: " .. err)
  end
  isUiOpen = display
end

-- Trigger on session start
Citizen.CreateThread(function()
    if NetworkIsSessionStarted() then
        TriggerEvent("chat:addSuggestion", "/watermark", "Toggle the watermark display")
        return
    end
end)

-- Event: Character selected
if config.framework == 'vorp' then
  RegisterNetEvent("vorp:SelectedCharacter")
  AddEventHandler("vorp:SelectedCharacter", function(charid)
      HandleCharacterSelection()
  end)
elseif config.framework == 'rsg' then
  RegisterNetEvent("RSGCore:Client:OnPlayerLoaded")
  AddEventHandler("RSGCore:Client:OnPlayerLoaded", function(data)
      HandleCharacterSelection()
  end)
elseif config.framework == 'redemrp' then
  RegisterNetEvent("redemrp_charselect:SpawnCharacter")
  AddEventHandler("redemrp_charselect:SpawnCharacter", function()
      HandleCharacterSelection()
  end)
else
  print("Error: Unsupported framework specified in Config.Framework")
end

function HandleCharacterSelection()
  Citizen.Wait(30000) -- Wait for 30 seconds
  isUiOpen = true
  TriggerEvent('DisplayWM', true)
end

-- Event: Display watermark
RegisterNetEvent('DisplayWM')
AddEventHandler('DisplayWM', function(status)
    if status then
        userTurnedOff = false 
        showWM(true)
    else
        userTurnedOff = true
        showWM(false)
    end
end)

-- Command: Toggle watermark
RegisterCommand('watermark', function()
  if config.allowoff then
      local newStatus = not isUiOpen
      TriggerEvent('DisplayWM', newStatus)
  else
      TriggerEvent('chat:addMessage', {
          color = {255, 0, 0},
          multiline = false,
          args = {"^9[RedM-WM] ^1This server has disabled the option to toggle the watermark!"}
      })
  end
end)

