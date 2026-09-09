require "NVFramework_Shared"
require "NVFramework_BatteryState"

local function onClientCommand(module, command, player, args)
	if module ~= "NVFramework" then return end
	if command ~= "SetNightVisionActive" then return end
	if not player then return end

	local enable = args and args.active == true
	local ok = NV.SetPlayerNightVisionState(player, enable, {
		playSound = true,
		syncLocal = true,
	})

	if not ok and sendServerCommand then
		sendServerCommand(player, "NVFramework", "SetLocalNightVision", {
			active = false,
			playSound = false,
			playerNum = player.getPlayerNum and player:getPlayerNum() or 0,
			onlineID = player.getOnlineID and player:getOnlineID() or nil,
		})
	end
end

Events.OnClientCommand.Add(onClientCommand)

print("[NV] Server sync loaded")
