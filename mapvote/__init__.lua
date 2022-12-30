
if game:getdvar("gamemode") ~= "mp" then -- If its not on multiplayer then don't execute the script
    return
end

require("hud")

local players = {}

local Config = {}
Config.maps = "mp_convoy mp_showdown mp_bog mp_crash mp_crossfire mp_citystreets mp_shipment mp_vacant mp_broadcast mp_bloc mp_killhouse mp_strike mp_crash_snow mp_backlot mp_farm mp_overgrown mp_carentan mp_creek mp_pipeline mp_cargoship mp_bog_summer"
Config.gametypes = "war dom hp"
Config.time = 20

Config.shaders = {}
Config.shaders.gradient_fadein = "gradient_fadein"
Config.shaders.gradient = "gradient"
Config.shaders.white = "white"
Config.shaders.line_vertical = "line_vertical"

Config.colors = {}
Config.colors.select = vector:new(0.09, 1, 0.09)
Config.colors.confirm = vector:new(0.968, 0.992, 0.043)
Config.colors.default = vector:new(0.035, 0.059, 0.063)

game:precacheshader(Config.shaders.gradient_fadein)
game:precacheshader(Config.shaders.gradient)
game:precacheshader(Config.shaders.white)
game:precacheshader(Config.shaders.line_vertical)

function maptoname( mapid )
    mapid = mapid:lower()
    if     mapid == "mp_convoy" then return "Ambush"
    elseif mapid == "mp_backlot" then return "Backlot"
    elseif mapid == "mp_bog" then return "Bog"
    elseif mapid == "mp_crash" then return "Crash"
    elseif mapid == "mp_crossfire" then return "Crossfire"
    elseif mapid == "mp_citystreets" then return "District"
    elseif mapid == "mp_farm" then return "Downpour"
    elseif mapid == "mp_overgrown" then return "Overgrown"
    elseif mapid == "mp_shipment" then return "Shipment"
    elseif mapid == "mp_vacant" then return "Vacant"
    elseif mapid == "mp_vlobby_room" then return "Lobby Map"
    elseif mapid == "mp_broadcast" then return "Broadcast"
    elseif mapid == "mp_carentan" then return "Chinatown"
    elseif mapid == "mp_countdown" then return "Countdown"
    elseif mapid == "mp_bloc" then return "Bloc"
    elseif mapid == "mp_creek" then return "Creek"
    elseif mapid == "mp_killhouse" then return "Killhouse"
    elseif mapid == "mp_pipeline" then return "Pipeline"
    elseif mapid == "mp_strike" then return "Strike"
    elseif mapid == "mp_showdown" then return "Showdown"
    elseif mapid == "mp_cargoship" then return "Wet Work"
    elseif mapid == "mp_crash_snow" then return "Winter Crash"
    elseif mapid == "mp_farm_spring" then return "Day Break"
    elseif mapid == "mp_bog_summer" then return "Beach Bog"
    end
    return mapid
end

function gametypetostring( gametype )
    gametype = gametype:lower()
    if     gametype == "war" then return "Team Deathmatch"
    elseif gametype == "dom" then return "Domination"
    elseif gametype == "hp" then return "Hardpoint"
    elseif gametype == "sd" then return "Search & Destroy"
    elseif gametype == "dm" then return "Free for all"
    elseif gametype == "conf" then return "Kill Confirmed"
    elseif gametype == "sab" then return "Sabotage"
    elseif gametype == "koth" then return "Headquarters"
    elseif gametype == "hp" then return "Hardpoint"
    elseif gametype == "gun" then return "Gun Game"
    elseif gametype == "ctf" then return "Capture The Flag"
    elseif gametype == "dd" then return "Demolition"
    end
    return gametype
end

function choosefromatable(list)
    random = math.random(1, #list )
    return random
end

function getminplayerstowin()
    return math.floor(tonumber(#players/2) + 1)
end

Config.running = false
function mapvote()
    Config.running = true
    local maps = split(Config.maps, " ")
    local maps_to_choose = split(Config.maps, " ")
    local maps_to_vote = {}
    maps_to_vote[1] = choosefromatable(maps_to_choose)
    table.remove(maps_to_choose, maps_to_vote[1])

    maps_to_vote[2] = choosefromatable(maps_to_choose)
    table.remove(maps_to_choose, maps_to_vote[2])

    maps_to_vote[3] = choosefromatable(maps_to_choose)
    table.remove(maps_to_choose, maps_to_vote[3])

    local gametypes = split(Config.gametypes, " ")
    local gametypes_to_vote = {}
    
    gametypes_to_vote[1] = choosefromatable(gametypes)
    gametypes_to_vote[2] = choosefromatable(gametypes)
    gametypes_to_vote[3] = choosefromatable(gametypes)

    local server_ui_objects = {}

    server_ui_objects.background_line = drawbox("icon", 0, 180, "center", "top", "center", "top", vector:new(0.0, 0.0, 0.0), 0.7, Config.shaders.white, (201*3)+(12*3), 121 )
    server_ui_objects.timer = drawtext("font", "objective", 1.3, 0, 100, "center", "top", "center", "top", vector:new(1, 1, 1), 1, "00:00")
    server_ui_objects.guide = drawtext("font", "objective", 1.3, 0, 120, "center", "top", "center", "top", vector:new(1, 1, 1), 1, "Press ^3[{+attack}] ^7and ^3[{+speed_throw}]^7/^3[{+toggleads_throw}]^7 ^7to scroll^7\nPress ^3[{+gostand}] ^7to confirm selection^7")

    server_ui_objects.mapnameandgametypemap1 = drawtext("font", "objective", 1.1, -220-80, 185, "left", "top", "center", "top", vector:new(1, 1, 1), 1, maptoname(maps[maps_to_vote[1]]) .. "\n\n\n\n\n\n\n" .. gametypetostring(gametypes[gametypes_to_vote[1]]))
    server_ui_objects.votes_map1 = drawtext("font", "objective", 1.2, -220+80, 278, "center", "top", "center", "top", vector:new(1, 1, 1), 1, "0")

    server_ui_objects.mapnameandgametypemap2 = drawtext("font", "objective", 1.1, 0-80, 185, "left", "top", "center", "top", vector:new(1, 1, 1), 1, maptoname(maps[maps_to_vote[2]]) .. "\n\n\n\n\n\n\n" .. gametypetostring(gametypes[gametypes_to_vote[2]]))
    server_ui_objects.votes_map2 = drawtext("font", "objective", 1.2, 0+80, 278, "center", "top", "center", "top", vector:new(1, 1, 1), 1, "0")
    
    server_ui_objects.mapnameandgametypemap3 = drawtext("font", "objective", 1.1, 220-80, 185, "left", "top", "center", "top", vector:new(1, 1, 1), 1, maptoname(maps[maps_to_vote[3]]) .. "\n\n\n\n\n\n\n" .. gametypetostring(gametypes[gametypes_to_vote[3]]))
    server_ui_objects.votes_map3 = drawtext("font", "objective", 1.2, 220+80, 278, "center", "top", "center", "top", vector:new(1, 1, 1), 1, "0")

    local votes = {} -- Votes for each map
    votes[1] = 0
    votes[2] = 0
    votes[3] = 0

    -- Remove and Addvote for map1
    level:onnotify("removevote1", function ()
        votes[1] = votes[1] - 1
        server_ui_objects.votes_map1:setvalue( votes[1] )
    end)

    level:onnotify("vote1", function ()
        votes[1] = votes[1] + 1
        server_ui_objects.votes_map1:setvalue( votes[1] )
    end)

    -- Remove and Addvote for map2
    level:onnotify("removevote2", function ()
        votes[2] = votes[2] - 1
        server_ui_objects.votes_map2:setvalue( votes[2] )
    end)

    level:onnotify("vote2", function ()
        votes[2] = votes[2] + 1
        server_ui_objects.votes_map2:setvalue( votes[2] )
    end)

    -- Remove and Addvote for map3
    level:onnotify("removevote3", function ()
        votes[3] = votes[3] - 1
        server_ui_objects.votes_map3:setvalue( votes[3] )
    end)

    level:onnotify("vote3", function ()
        votes[3] = votes[3] + 1
        server_ui_objects.votes_map3:setvalue( votes[3] )
    end)

    -- Timer
    server_ui_objects.timer:settimer(Config.time)
    local loop = game:oninterval(function ()
        Config.time = Config.time - 1
        
        if Config.time == 0 then -- When time reach 0 the mapvote end
            if votes[1] > votes[2] and votes[1] > votes[3] then -- map1 is the winner
                game:executecommand('set sv_maprotationcurrent "gametype ' .. gametypes[gametypes_to_vote[1]] .. ' map ' .. maps[maps_to_vote[1]] .. '"')
            elseif votes[2] > votes[1] and votes[2] > votes[3] then -- map1 is the winner
                game:executecommand('set sv_maprotationcurrent "gametype ' .. gametypes[gametypes_to_vote[2]] .. ' map ' .. maps[maps_to_vote[2]] .. '"')
            else
                game:executecommand('set sv_maprotationcurrent "gametype ' .. gametypes[gametypes_to_vote[3]] .. ' map ' .. maps[maps_to_vote[3]] .. '"')
            end

            level:notify("end_vote")
            for index, player in ipairs(players) do
                player:notify("end_vote_client") -- Destroy client UI
            end

            server_ui_objects.background_line:destroy()
            server_ui_objects.timer:destroy()
            server_ui_objects.guide:destroy()

            server_ui_objects.mapnameandgametypemap1:destroy()
            server_ui_objects.votes_map1:destroy()
        
            server_ui_objects.mapnameandgametypemap2:destroy()
            server_ui_objects.votes_map2:destroy()
            
            server_ui_objects.mapnameandgametypemap3:destroy()
            server_ui_objects.votes_map3:destroy()
        end
    end, 1000)

    loop:endon(level, "end_vote")

    for index, player in ipairs(players) do
        player:notify("start_vote")
        player:setclientomnvar("ui_use_mlg_hud", 1)
    end
 
end

local final_killcam = nil
final_killcam = game:detour("maps/mp/gametypes/_damage", "endfinalkillcam", function()

    level:onnotifyonce("end_vote", function()
        if Config.running then
            Config.running = false
            game:ontimeout(function()
                final_killcam.invoke()
            end, 2000)
        end
    end)

    if game:scriptcall("maps/mp/_utility", "waslastround") == 1 and #players >= 1 then -- if is wasthelastround() and there at least one player start the mapvote
        mapvote()
    else
        level:notify("end_vote")
    end
end)


--[[ Player Management ]]--
function entity:onPlayerDisconnect()
    local index = tablefind(players, self)
	if index ~= nil then
		table.remove(players, index)
	end
end
function entity:isentityabot()
	return string.find(self:getguid(), "bot")
end

function onPlayerConnected( player )
    if not player:isentityabot() and not Config.running then
        table.insert(players, player)
        local disconnectListener = player:onnotifyonce("disconnect", function ()  player:onPlayerDisconnect() end)

        player:onnotifyonce("start_vote", function ()
            
            local voted = false
        
            local client_ui_object = player:drawbox("bar", -220, 182, "center", "top", "center", "top", Config.colors.select, 1, Config.shaders.white, 196, 116 )

            local current_index = 1
            local validate_input = true
            player:notifyonplayercommand("next", "+attack")
            player:onnotify("next", function ()
                if not voted and validate_input then
                    validate_input = false
                    current_index = current_index + 1
                    if current_index > 3 then
                        current_index = 1
                        client_ui_object:affectElement("x", 0.2, -220)
                    elseif current_index == 2 then
                        client_ui_object:affectElement("x", 0.2, 0)
                    else
                        client_ui_object:affectElement("x", 0.2, 220)
                    end
                    game:ontimeout(function ()
                        validate_input = true
                    end, 200)
                end
            end)

            player:notifyonplayercommand("back", "+speed_throw")
            player:notifyonplayercommand("back", "+toggleads_throw")
            player:onnotify("back", function ()
                if not voted and validate_input  then
                    validate_input = false
                    current_index = current_index - 1
                    if current_index < 1 then
                        current_index = 3
                        client_ui_object:affectElement("x", 0.2, 220)
                    elseif current_index == 2 then
                        client_ui_object:affectElement("x", 0.2, 0)
                    else
                        client_ui_object:affectElement("x", 0.2, -220)
                    end
                    game:ontimeout(function ()
                        validate_input = true
                    end, 200)
                end
            end)

            player:onnotifyonce("end_vote_client", function ()
                client_ui_object:destroy()
            end)

            player:notifyonplayercommand("vote", "+gostand")
            player:onnotifyonce("vote", function ()
                level:notify("vote"..current_index)
                client_ui_object.color = Config.colors.confirm
                voted = true
            end)

            player:onnotifyonce("disconnect", function ()
                if voted then
                    level:notify("removevote"..current_index)
                end
                player:notify("end_vote_client")
            end)
        end)

        player:onnotifyonce("disconnect", function ()
            disconnectListener:clear()
        end)
    end
end

--[[ Tables Utils ]]--
function tablefind(tab,el)
	for index, value in pairs(tab) do
		if value == el then
			return index
		end
	end
	return nil
end

-- [[ Utilities ]] --
function split(pString, pPattern)
    local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
      table.insert(Table,cap)
       end
       last_end = e+1
       s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
       cap = pString:sub(last_end)
       table.insert(Table, cap)
    end
    return Table
end

level:onnotify("connected", onPlayerConnected)
