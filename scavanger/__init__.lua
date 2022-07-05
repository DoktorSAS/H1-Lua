--[[
    Scavanger drop mod 
    Developed by @DoktorSAS && yoyo1love

    Support the creator on Patreon at https://www.patreon.com/DoktorSAS
]]

local players = {}
game:precachemodel("weapon_scavenger_grenadebag")
local forcePointVariance = 200.0;
local vertVelocityMin = -100.0;
local vertVelocityMax = 100.0;

local scavangers = {}
game:precachesound("scavenger_pack_pickup")
game:oninterval(function ()
    local scavangersToRemove = {}
    for sindex, scavanger in ipairs(scavangers) do
        if scavanger.used == 0 and scavanger.ttl > 0 then
            for pindex, player in ipairs(players) do
                if player ~= scavanger.owner and game:distance(player.origin, scavanger.origin) < 42 then
                    player:setclientomnvar( "damage_feedback", "hitmorehealth");
                    player:playsound("scavenger_pack_pickup")
                    table.insert(scavangersToRemove, sindex)
                    scavanger.used = 1
                    local offhandWeapons = player:getweaponslistoffhands()
                    for windex, offhand in ipairs(offhandWeapons) do
                        if player:getweaponammoclip( offhand ) < 1 then
                            player:setweaponammoclip( offhand, player:getweaponammoclip( offhand ) + 1 )
                        end
                    end

                    local weapons = player:getweaponslistprimaries()
                    for windex, weapon in ipairs(weapons) do
                         player:setweaponammostock( weapon, player:getweaponammoclip( weapon ) + game:weaponclipsize( weapon ) )
                    end
                end
            end
            scavanger.ttl = scavanger.ttl - 1
        elseif scavanger.ttl <= 0 then
            table.insert(scavangersToRemove, sindex)
        end 
    end

    for i = 1, #scavangersToRemove, 1 do
        local current = scavangers[ scavangersToRemove[i] ]
        if current ~= nil then
            current:delete()
            table.remove(scavangers, scavangersToRemove[i] )
        end
    end

end, 200)

game:onplayerkilled(function(_self, _inflictor, _attacker, damage, _mod, _weapon, _vPoint, _vDir, _hitLoc)
    if _self ~= nil and _mod ~= "MOD_FALLING" and _mod ~= "MOD_SUICIDE" then
        
        local scavanger = game:spawn("script_model", _self.origin + vector:new(0,0,15))
        scavanger:setmodel("weapon_scavenger_grenadebag")
        scavanger.angles = vector:new(0,0,90)
        scavanger.owner = _self
        scavanger.ttl = 10
        scavanger.used = 0
    
        forcePointX = game:randomfloatrange( 0-forcePointVariance, forcePointVariance )
        forcePointY = game:randomfloatrange( 0-forcePointVariance, forcePointVariance )
        forcePoint = vector:new( forcePointX, forcePointY, 0 )
        forcePoint = forcePoint + scavanger.origin;
        initialVelocityZ = game:randomfloatrange( vertVelocityMin, vertVelocityMax )
        initialVelocity = vector:new( 0, 0, initialVelocityZ );
        scavanger:physicslaunchclient(forcePoint,initialVelocity)
        game:ontimeout(function ()
            table.insert(scavangers, scavanger)
        end, 750)
    end
end)

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
    
    local disconnectListener = player:onnotifyonce("disconnect", function ()  player:onPlayerDisconnect() end);

    player:onnotifyonce("disconnect", function ()
        disconnectListener:clear()
    end);
end

level:onnotify("connected", onPlayerConnected)
