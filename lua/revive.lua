local mplayer = managers.player
local currenthost = mplayer._players[1]

if not Global.game_settings.single_player then 
	return 
else
	if managers.job:current_level_id() == "modders_devmap" and alive(currenthost) then
		currenthost:base():replenish()
		currenthost:character_damage():set_health(PGEnhance.Settings.current_health)
	end
end