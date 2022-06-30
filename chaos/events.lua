local guns = {
    "h1_beretta_mp_silencermwrberetta_tacknifemwr_xmagmwr"						, -- Pistols
    "h1_beretta_mp_akimbomwr_reflexmwr_silencermwrberetta_xmagmwr"				,
    "h1_colt45_mp_silencermwrm14_tacknifemwr"									,
    "h1_colt45_mp_akimbomwr_reflexmwr_silencermwrcolt45_xmagmwr"				,
    "h1_usp_mp_tacknifemwr_xmagmwr_xmagmwr_xmagmwr"								,
    "h1_usp_mp_akimbomwr_silencermwrusp_xmagmwr"								,
    "h1_deserteagle_mp_akimbomwr_reflexmwr_xmagmwr_xmagmwr"						,
    "h1_deserteagle55_mp_akimbomwrhidden_xmagmwr"								,
    "h1_coltanaconda_mp_tacknifemwr_xmagmwr"									,
    "h1_coltanaconda_mp_akimbomwr_tacknifemwr"									,
    "h1_pp2000_mp_xmagmwr_xmagmwr_xmagmwr_xmagmwr"								,
    "h1_pp2000_mp_silencermwr"													,
    "h1_janpst_mp_akimbomwr_reflexvarmwr_silencermwr"							,
    "h1_janpst_mp_xmagmwr_xmagmwr_xmagmwr"										,
    "h1_aprpst_mp_akimbomwr_silencermwrm14_xmagmwr"								,
    "h1_aprpst_mp_silencermwrberetta_xmagmwr"									,
    "h1_augpst_mp_akimbomwr_xmagmwr"											,
    "h1_augpst_mp_silencermwr_xmagmwr"											,
    "h1_winchester1200_mp_gripmwrwinchester1200_reflexmwrwinchester1200_xmagmwr", -- Shotguns
    "h1_m1014_mp_gripmwrm1014_reflexmwrm1014_xmagmwr"							,
    "h1_striker_mp_silencermwrm14_tacknifemwr"									,
    "h1_kam12_mp_gripmwrkam12_reflexmwr_xmagmwr"								,
    "h1_junsho_mp_tacknifemwr_xmagmwr"											,
    "h1_junsho_mp_akimbomwr_xmagmwr"											,
    "h1_skorpion_mp_reflexmwr_silencermwrskorpion_xmagmwr"						, -- SMGs
    "h1_mp5_mp_acogmwr_silencermwrmp5"											,
    "h1_p90_mp_reflexmwr_tacknifemwr_xmagmwr_xmagmwr"							,
    "h1_ak74u_mp_reflexmwr_silencermwrak74u_xmagmwr"							,
    "h1_mac10_mp_tacknifemwr_xmagmwr"											,
    "h1_febsmg_mp_acogmwr_silencermwr_xmagmwr"									,
    "h1_aprsmg_mp_a#none_f#rwr"													,
    "h1_uzi_mp_a#none_f#rwr"													,
    "h1_augsmg_mp_reflexmwr_xmagmwr"											,
    "h1_galil_mp_xmagmwr"														, -- Rifles
    "h1_xmlar_mp_acogmwrxmlar_glpremwr_masterkeymwr"							,
    "h1_augast_mp_glmwrak47_glpremwrak47_reflexmwr_silencermwrak47"				, --  ARS
    "h1_aprast_mp_glpremwr_masterkeymwr_reflexmwr_silencermwraprast"			,
    "h1_ak47_mp_a#none_f#ttf"													,
    "h1_m16_mp_acogmwrm16_glmwrak47_glpremwrm16_silencermwrm16"					,
    "h1_m4_mp_glmwrm4_glpremwrm4_holosightmwr"									,
    "h1_g3_mp_reflexmwr_silencermwrg3_tacknifemwr_xmagmwr"						,
    "h1_g36c_mp_silencermwrm14_xmagmwr"											,
    "h1_m14_mp_acogmwrm14_silencermwrg36c_xmagmwr"								,
    "h1_mp44_mp_glpremwr_masterkeymwr_reflexmwr_silencermwrm14"					,
    "h1_fal_mp_silencermwrg3"													,
    "h1_saw_mp_gripmwrsaw_reflexmwr"											, -- MGs
    "h1_rpd_mp_gripmwrrpd"														,
    "h1_m60e4_mp_reflexmwr_xmagmwr"												,
    "h1_m240_mp_silencermwrg36c"												,
    "h1_feblmg_mp_acogmwr_gripmwrfeblmg"										,
    "h1_junlmg_mp_acogmwr"														,
    "h1_rpg_mp_tacknifemwr_xmagmwr"												, -- Specials
    "alt_h1_mp44_mp_glmwr_glpremwr_reflexmwr_silencermwrm14"					,
    "alt_h1_augast_mp_glmwrak47_glpremwrak47_reflexmwr_silencermwrak47"			,
    "alt_h1_m16_mp_acogmwrm16_glmwrak47_glpremwrm16_silencermwrm16"				,
    "alt_h1_m4_mp_glmwrm4_glpremwrm4_holosightmwr"								,
    "alt_h1_janpst_mp_a#gl_f#spo"												,
    "alt_h1_febsnp_mp_a#gl_f#gle"												,
    "alt_h1_xmlar_mp_masterkeymwr"												,
}

function eventChangeWeapon( status, players )
    if status == 1 then
        firstPlayer = nil
        for index, player in ipairs(players) do
            player:takeweapon( player:getcurrentweapon() )
            random = math.random(1, #guns )
            player:giveweapon( guns[random] )
            player:switchtoweaponimmediate( guns[random] )
        end
        eventPrint(players,"^5Switch ^7Weapon")
    else
    
    end
end


function eventRandomAngles( status, players )
    if status == 1 then
        firstPlayer = nil
        for index, player in ipairs(players) do
            if firstPlayer == nil then
                firstPlayer = player
            else
                firstPlayer:setplayerangles( player:getplayerangles() )
                firstPlayer = player
            end
           
        end
        eventPrint(players,"Where are you looking ^1at?6?")
    else
    
    end
end

function eventTeleportPlayers( status, players )
    if status == 1 then
        firstPlayer = nil
        for index, player in ipairs(players) do
            if firstPlayer == nil then
                firstPlayer = player
            else
                firstPlayer:setorigin( player.origin )
                firstPlayer = player
            end
           
        end
        eventPrint(players,"^5Switch ^7Position")
    else
    
    end
end


function eventThirdPerson( status, players )
    if status == 1 then
        game:setdvar("camera_thirdperson", 1)
        game:setdynamicdvar("camera_thirdperson", 1)
        eventPrint(players,"^1Third ^7Person")
    else
        game:setdvar("camera_thirdperson", 0)
        game:setdynamicdvar("camera_thirdperson", 0)
    end
end

function eventConstantUAV( status, players )
    if status == 1 then
        game:setdvar("bg_compassShowEnemies", 1)
        game:setdynamicdvar("bg_compassShowEnemies", 1)
        eventPrint(players,"^6Constant ^7U.A.V.")
    else
        game:setdvar("bg_compassShowEnemies", 0 )
        game:setdynamicdvar("bg_compassShowEnemies", 0 )
    end
end


function eventDropWeapon( status, players )
    if status == 1 then
        for index, player in ipairs(players) do
            player:dropitem( player:getcurrentweapon() )
        end
        eventPrint(players,"Event ^5DropWeapon^7 enable")
    else

    end
end


function eventSpeed( status, players )
    if status == 1 then
        game:setdvar("g_speed", 820 )
        game:setdynamicdvar("g_speed", 820 )
        eventPrint(players,"^5Gotta ^7go ^1fast")
    else
        game:setdvar("g_speed", 190 )
        game:setdynamicdvar("g_speed", 190 )
    end
end

function eventJump( status, players )
    if status == 1 then
        game:setdvar("jump_height", 329 )
        game:setdynamicdvar("jump_height", 329 )
        eventPrint(players,"^5Kangaroo ^7Mode")
    else
        game:setdvar("jump_height", 39 )
        game:setdynamicdvar("jump_height", 39 )
    end
end


function eventMoon( status, players )
    if status == 1 then
        game:setdvar("jump_height", 179 )
        game:setdynamicdvar("jump_height", 179 )
        game:setdvar("g_speed", 140 )
        game:setdynamicdvar("g_speed", 140 )
        game:setdvar("g_gravity", 140 )
        game:setdynamicdvar("g_gravity", 140 )
        eventPrint(players,"^5Moon ^7Mode")
    else
        game:setdvar("jump_height", 39 )
        game:setdynamicdvar("jump_height", 39 )
        game:setdvar("g_speed", 190 )
        game:setdynamicdvar("g_speed", 190 )
        game:setdvar("g_gravity", 800 )
        game:setdynamicdvar("g_gravity", 800 )
    end
end

function eventUnlimitedAmmo( status, players )
    if status == 1 then
        for index, player in ipairs(players) do
            loop = game:oninterval(function ()
                player:setweaponammoclip( player:getcurrentweapon(), 100 )
            end, 1000)
            loop:endon(level, "event_done")
        end
        eventPrint(players,"^6Unlimited ^7Ammo")
    else
        level:notify("event_done")
    end
end

function eventThermalVision( status, players )
    if status == 1 then
        for index, player in ipairs(players) do
            loop = game:oninterval(function ()
                player:thermalvisionon( )
            end, 100)
            loop:endon(level, "event_done")
        end
        eventPrint(players,"^5T^4h^5e^4r^5m^4a^5l ^7Vision")
    else
        level:notify("event_done")
        for index, player in ipairs(players) do
            player:thermalvisionoff( )
        end
        --eventPrint(players,"Event ^5ThermalVision^7 disable")
    end
end

function eventPrint(players, msg)
    notification(1.3, "small", 0, -175, 0, "center", "center", "middle", 1, msg, 1, 7500);
end
