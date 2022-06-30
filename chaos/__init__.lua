
require("hud")
require("events")

--[[
    C.H.A.O.S. Mod 
    Developed by @DoktorSAS

    Support the creator on Patreon at https://www.patreon.com/DoktorSAS
]]

local events = {}
events[0] = eventTeleportPlayers
events[1] = eventThirdPerson
events[2] = eventSpeed
events[3] = eventConstantUAV
events[4] = eventDropWeapon
events[5] = eventUnlimitedAmmo
events[6] = eventThermalVision
events[7] = eventSpeed
events[8] = eventJump
events[9] = eventChangeWeapon
events[10] = eventMoon
events[11] = eventRandomAngles

local background = nil
local bar = nil
local time = nil
local timeIntervall = 30

local players = {}

game:setdvar("developed", "by DoktorSAS")
game:setdvar("g_oldschool", 0)
game:setdvar("jump_slowdownEnable", 0)
game:setdvar("jump_enableFallDamage", 0)
game:setdvar("pm_bouncing", 1)
game:setdvar("pm_bouncingAllAn", 1)


-- [[ Disable Killstreaks ]]--
game:setdvar("scr_killstreak_kills_uav", 1000)
game:setdynamicdvar("scr_killstreak_kills_uav", 1000)
game:setdvar("scr_killstreak_kills_airstrike", 1000)
game:setdynamicdvar("scr_killstreak_kills_airstrike", 1000)
game:setdvar("scr_killstreak_kills_heli", 1000)
game:setdynamicdvar("scr_killstreak_kills_heli", 1000)

--[[ Reset Dvars ]]--
game:setdvar("bg_compassShowEnemies", 0 )
game:setdynamicdvar("bg_compassShowEnemies", 0 )
game:setdvar("camera_thirdperson", 0)
game:setdynamicdvar("camera_thirdperson", 0)
game:setdvar("jump_height", 39 )
game:setdynamicdvar("jump_height", 39 )
game:setdvar("g_speed", 190 )
game:setdynamicdvar("g_speed", 190 )
game:setdvar("g_gravity", 800 )
game:setdynamicdvar("g_gravity", 800 )

function entity:onPlayerSpwned()
    self:notification(0.9, "hudsmall", 0, 35, 0, "center", "center", "middle", 1, "Welcome to ^1C.^3H.^1A.^3O.^1S ^7MOD\nDeveloped by @^5DoktorSAS", 0.7, 10000);
end

function tablefind(tab,el)
	for index, value in pairs(tab) do
		if value == el then
			return index
		end
	end
	return nil
end

function entity:onPlayerDisconnect()

    local index = tablefind(players, self)
	if index ~= nil then
		table.remove(players, index)
	end
end

function onPlayerConnected( player )

    table.insert(players, player)
    
    local deathListener = player:onnotify("death", function ()  end);
    local spawnListener = player:onnotifyonce("spawned_player", function ()  player:onPlayerSpwned() end);
    local disconnectListener = player:onnotifyonce("disconnect", function ()  player:onPlayerDisconnect() end);

    player:onnotifyonce("disconnect", function ()
        spawnListener:clear()
        disconnectListener:clear()
        deathListener:clear()
    end);
end

local currentEvent = -1

function doCaosEvent( )

    random = math.random(0, #events )
    while random == currentEvent do
        random = math.random(0, #events )
        if random == #events then
            currentEvent = random - 1
        else
            currentEvent = random + 1
        end
    end
    currentEvent = random

    events[ currentEvent ]( 1, players )
end


level:onnotifyonce("connected", function ()
    bar = drawbox("icon", -120, -51, "center", "bottom", "center", "bottom", vector:new(0.2, 0.6, 0.3), 0, "white", 75, 10)
    background = drawbox("icon", -120, -30, "center", "bottom", "center", "bottom", vector:new(0.0, 0.0, 0.0), 0, "white", 75, 22)
    timer = drawtext("font", "objective", 1.7, -120, -30, "center", "bottom", "center", "bottom", vector:new(1, 1, 1), 0, 0)
    timer:setvalue( timeIntervall );
    level:onnotifyonce("prematch_done", function ()
        background:affectElement("alpha", 1, 0.6)
        bar:affectElement("alpha", 1, 1)
        timer:affectElement("alpha", 1, 1)
        time = 30
        doCaosEvent()
        for index, player in ipairs(players) do
            player:playsound("freefall_death")
        end
        endgame = nil
        level:onnotifyonce("game_ended", function ()
            endgame:clear()
            background:destroy()
            bar:destroy()
            timer:destroy()
        end);
        endgame = game:oninterval(function ()
            time = time - 1
            if time == 0 then
                timer:setvalue( timeIntervall );
                time = timeIntervall
                events[ currentEvent ]( 0, players)
                doCaosEvent( )
                for index, player in ipairs(players) do
                    player:playsound("freefall_death")
                end
            else
                if time < 5 then
                    for index, player in ipairs(players) do
                        player:playsound("ui_mp_timer_countdown")
                    end
                end
                timer:setvalue( time );
            end
        end, 1000)
      
    end)
end)


level:onnotifyonce("connected", function ()

end)

level:onnotify("connected", onPlayerConnected)
