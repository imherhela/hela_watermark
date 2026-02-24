-----------------------------------------------------------------
-- Logo Watermark- A Simple FiveM Script, Made By Jordan.#2139 --
--  RedM Watermark- A simple RedM script, Edited by ImHerHela	 --
-----------------------------------------------------------------

local display = true
local showing = false
local isUiOpen = false
local isCharacterSelected = false
local userTurnedOff = false

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while not DoesEntityExist(PlayerPedId()) or not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(500)
    end

    while true do
        if not isCharacterSelected then
            Citizen.Wait(500)
        else
            local isMapOrUiActive = IsRadarHidden() or IsPauseMenuActive()

            if display then
                
                if isMapOrUiActive and showing then
                    SendNUIMessage({ type = 'DisplayWM', visible = false, position = Config.position })
                    showing = false
                elseif not isMapOrUiActive and not showing and not userTurnedOff then
                    SendNUIMessage({ type = 'DisplayWM', visible = true, position = Config.position })
                    showing = true
                end
            end

            Citizen.Wait(500)
        end
    end
end)

function ShowWM(display)
  local success, err = pcall(function()
      SendNUIMessage({
          type = 'DisplayWM',
          visible = display,
          position = Config.position 
      })
  end)
  if not success then
      print("^1Error sending NUI message: " .. err)
  end
  isUiOpen = display
end

Citizen.CreateThread(function()
    if NetworkIsSessionStarted() then
        TriggerEvent("chat:addSuggestion", "/watermark", "Toggle the watermark display")
        return
    end
end)

if Config.framework == 'vorp' then
  RegisterNetEvent("vorp:SelectedCharacter")
  AddEventHandler("vorp:SelectedCharacter", function(charid)
      HandleCharacterSelection()
  end)
elseif Config.framework == 'rsg' then
  RegisterNetEvent("RSGCore:Client:OnPlayerLoaded")
  AddEventHandler("RSGCore:Client:OnPlayerLoaded", function(data)
      HandleCharacterSelection()
  end)
elseif Config.framework == 'redemrp' then
  RegisterNetEvent("redemrp_charselect:SpawnCharacter")
  AddEventHandler("redemrp_charselect:SpawnCharacter", function()
      HandleCharacterSelection()
  end)
else
  print("Error: Unsupported framework specified in Config.Framework")
end

function HandleCharacterSelection()
    isCharacterSelected = true
    Citizen.Wait(15000) 
    isUiOpen = true
    TriggerEvent('DisplayWM', true)
end

RegisterNetEvent('DisplayWM')
AddEventHandler('DisplayWM', function(status)
    if status then
        userTurnedOff = false 
        SendNUIMessage({ type = 'DisplayWM', visible = true, position = Config.position })
        showing = true
    else
        userTurnedOff = true
        SendNUIMessage({ type = 'DisplayWM', visible = false, position = Config.position })
        showing = false
    end
end)

RegisterCommand('watermark', function()
  if Config.allowoff then
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


CreateThread(function()
    local DisableTabWheelCompass = true
	
    if DisableTabWheelCompass then
	while true do
		Wait(1)
        if Citizen.InvokeNative(0x96FD694FE5BE55DC, GetHashKey("hud_quick_select")) == 1322164459 or Citizen.InvokeNative(0x96FD694FE5BE55DC, GetHashKey("hud_quick_select")) == 400623090 then
		DisplayRadar(false)
			end
		end
	end
end)

