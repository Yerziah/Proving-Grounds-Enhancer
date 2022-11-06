local mplayer = managers.player
local currenthost = mplayer._players[1]

if not Global.game_settings.single_player then 
	return 
else
	if managers.job:current_level_id() == "modders_devmap" then
		if alive(currenthost) then
			currenthost:base():replenish()
			mplayer:set_player_state("standard")
		end
	end
end