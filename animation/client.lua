-- Based on MasterCedric (https://github.com/MasterCedric/), modification by GalaxHD551

animationWheelUI = nil

function OnPackageStart()
	animationWheelUI = CreateWebUI(0, 0, 0, 0, 60)
	LoadWebFile(animationWheelUI, "http://asset/" .. GetPackageName() .. "/animation/web/index.html")
	SetWebSize(animationWheelUI, 700, 700)
	SetWebAlignment(animationWheelUI, 0.5, 0.5)
	SetWebAnchors(animationWheelUI, 0.5, 0.5, 0.5, 0.5)
	SetWebVisibility(animationWheelUI, WEB_HIDDEN)
end
AddEvent("OnPackageStart", OnPackageStart)

-- HANDS UP // aqui
AddEvent ("OnKeyPress", function(key)
	local cuffed = GetPlayerPropertyValue(GetPlayerId(), "cuffed") or false
	if key == ANIMATION_HANDSUP_KEY and not IsPlayerInVehicle(GetPlayerId()) and not GetPlayerBusy() and not cuffed then
		if not IsPlayerPlayingAnimation(GetPlayerId()) then
			if IsCtrlPressed() then
				CallRemoteEvent("Server_OnPlayerAnimation", "HANDSHEAD_KNEEL")
			else
				CallRemoteEvent("Server_OnPlayerAnimation", "HANDSHEAD_STAND")
			end
		else
			CallRemoteEvent("Server_OnPlayerAnimation", "STOP")
		end
	end
end)
-- FIM HANDSUP

AddEvent("OnKeyPress", function(key)
	local cuffed = GetPlayerPropertyValue(GetPlayerId(), "cuffed") or false
	if key == ANIMATION_MENU_KEY and not IsPlayerInVehicle(GetPlayerId()) and not GetPlayerBusy() and not cuffed then
		if (GetWebVisibility(animationWheelUI) == 0) then
			local ScreenX, ScreenY = GetScreenSize()
			SetMouseLocation(math.floor(ScreenX / 2), math.floor(ScreenY / 2))
			SetWebVisibility(animationWheelUI, WEB_VISIBLE)
			ShowMouseCursor(true)
			SetInputMode(INPUT_GAMEANDUI)
		else
			SetWebVisibility(animationWheelUI, WEB_HIDDEN)
			ShowMouseCursor(false)
			SetInputMode(INPUT_GAME)
		end
	end
end)

function OnPlayerAnimation(id)
	SetWebVisibility(animationWheelUI, WEB_HIDDEN)
	ShowMouseCursor(false)
	SetInputMode(INPUT_GAME)
	CallRemoteEvent("Server_OnPlayerAnimation", id)
end
AddEvent("OnPlayerAnimation", OnPlayerAnimation)

AddEvent("drop", function(player)
	if not IsPlayerReloading(GetPlayerId()) then
		SetWebVisibility(animationWheelUI, WEB_HIDDEN)
		ShowMouseCursor(false)
		SetInputMode(INPUT_GAME)
		local slot = GetPlayerEquippedWeaponSlot()
		local model, ammo, mag = GetPlayerWeapon(slot)
		local bool = nil
		local bool = IsPlayerCrouching(bool)
		CallRemoteEvent("DropGun", mag, bool)
	end	
end)

-- PLAYER LIPS
AddEvent("OnPlayerTalking", function(player)
	SetPlayerLipMovement(player)
end)
