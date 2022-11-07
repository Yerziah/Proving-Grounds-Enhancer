_G.PGEnhance = _G.PGEnhance or {}
PGEnhance.ModPath = ModPath
PGEnhance.SaveFile = SavePath .. "PGEnhance.txt"
PGEnhance.Settings = {}

function PGEnhance:Reset()
    self.Settings = {
        current_health = 100,
    }
end

function PGEnhance:Load()
    local file = io.open(self.SaveFile,"r")
    if file then
        for k, v in pairs(json.decode(file:read('*all')) or {}) do
            self.Settings[k]=v
        end
        file:close()
    else
        self:Reset()
    end
end

function PGEnhance:Save()
    local file = io.open( self.SaveFile, "w+" )
    if file then
        file:write( json.encode( self.Settings ) )
        file:close()
    end
    PGEnhance:Load()
end



Hooks:Add("LocalizationManagerPostInit" , "LocalizationManagerPostInit_PGEnhance" , function( loc )
	loc:load_localization_file( PGEnhance.ModPath .. "loc/english.txt", false )
end )

Hooks:Add( "MenuManagerInitialize", "MenuManagerInitialize_PGEnhance", function()
    function MenuCallbackHandler:PGEnhanceSave(item)
        PGEnhance:Save()
    end

    function MenuCallbackHandler:set_current_health(item)
        if Utils:IsInHeist() and managers.job:current_level_id() == "modders_devmap" and Global.game_settings.single_player then
            local player = managers.player:player_unit()
            PGEnhance.Settings.current_health = item:value() * player:character_damage():_max_health() / 100

            player:character_damage():set_health(PGEnhance.Settings.current_health)
        end
    end

    MenuHelper:LoadFromJsonFile( PGEnhance.ModPath .. "options.txt", PGEnhance, PGEnhance.Settings )
end )