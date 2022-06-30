
--[[
    HUD Common by DoktorSAS
    
    Add to your __init__.lua require("hud") to include this function
    
    entity:notification is used for player type writer animated text, so elements visible to a specific player.
    GSC: self notification(... , ..., ...)
    LUA: self:notification(... , ..., ...) or player:notification(... , ..., ...)
    
    notification is used for server type writer animated text, so elements visible to all.
    GSC: level notification(... , ..., ...)
    LUA: notification(... , ..., ...)
    
    entity:drawtext and entity:drawbox is used for player hud elements, so elements visible to a specific player.
    GSC: self drawtext(... , ..., ...)
    LUA: self:drawtext(... , ..., ...) or player:drawtext(... , ..., ...)

    drawtext and drawbox is used for server hud elements, so elements visible to all.
    GSC: level drawtext(... , ..., ...)
    LUA: drawtext(... , ..., ...)

    affectElement is for animations, fadein, fadeout and moving animation.
    GSC: hudelem affectElement(... , ..., ...)
    LUA: hudelem:affectElement(... , ..., ...)
]]


function entity:notification(fontscale, font, x, y, z, alignx, horzalign, vertalign, alpha, label, glowalpha, pulse_time)
    local elem = game:newclienthudelem(self);
    elem.fontscale = fontscale;
    elem.font = font;
    elem.x = x;
    elem.y = y;
    elem.z = z;
    elem.alignx = alignx;
    elem.horzalign = horzalign;
    elem.vertalign = vertalign;
    elem.alpha = alpha;
    elem:settext(label);
    elem.sort = 1;
    elem.foreground = true;
    elem.glowalpha = glowalpha;
    
    elem:setpulsefx(100, pulse_time, 100);
    
    game:ontimeout(function()
        elem:destroy()
    end, pulse_time+100)
end

function notification(fontscale, font, x, y, z, alignx, horzalign, vertalign, alpha, label, glowalpha, pulse_time)
    local elem = game:newhudelem();
    elem.fontscale = fontscale;
    elem.font = font;
    elem.x = x;
    elem.y = y;
    elem.z = z;
    elem.alignx = alignx;
    elem.horzalign = horzalign;
    elem.vertalign = vertalign;
    elem.alpha = alpha;
    elem:settext(label);
    elem.sort = 1;
    elem.foreground = true;
    elem.glowalpha = glowalpha;
    
    elem:setpulsefx(100, pulse_time, 100);
    
    game:ontimeout(function()
        elem:destroy()
    end, pulse_time+100)

end

function entity:drawtext(type, font, fontscale, x, y, alignx, aligny, horzalign, vertalign, color, alpha, text, islevel)
    local elem = game:newclienthudelem(self)
    elem.elemType = type
    elem.font = font
    elem.fontscale = fontscale
    elem.x = x
    elem.y = y
    elem.alignx = alignx
    elem.aligny = aligny
    elem.horzalign = horzalign
    elem.vertalign = vertalign
    elem.color = color
    elem.alpha = alpha
    elem:settext(text)
    elem.hidewheninmenu = true

    return elem
end

function drawtext(type, font, fontscale, x, y, alignx, aligny, horzalign, vertalign, color, alpha, text)
    local elem = game:newhudelem()
    elem.elemType = type
    elem.font = font
    elem.fontscale = fontscale
    elem.x = x
    elem.y = y
    elem.alignx = alignx
    elem.aligny = aligny
    elem.horzalign = horzalign
    elem.vertalign = vertalign
    elem.color = color
    elem.alpha = alpha
    elem:settext(text)
    elem.hidewheninmenu = true

    return elem
end

function entity:drawbox(type, x, y, alignx, aligny, horzalign, vertalign, color, alpha, material, matwidth, matlength)
    local elem = game:newclienthudelem(self)
    elem.elemType = type
    elem.x = x
    elem.y = y
    elem.alignx = alignx
    elem.aligny = aligny
    elem.horzalign = horzalign
    elem.vertalign = vertalign
    elem.color = color
    elem.alpha = alpha
    elem:setshader(material, matwidth, matlength)
    elem.hidewheninmenu = true

    return elem
end

function drawbox(type, x, y, alignx, aligny, horzalign, vertalign, color, alpha, material, matwidth, matlength)
    local elem = game:newhudelem()
    elem.elemType = type
    elem.x = x
    elem.y = y
    elem.alignx = alignx
    elem.aligny = aligny
    elem.horzalign = horzalign
    elem.vertalign = vertalign
    elem.color = color
    elem.alpha = alpha
    elem:setshader(material, matwidth, matlength)
    elem.hidewheninmenu = true

    return elem
end

function entity:affectElement(type, time, value)
    if type == "x" or type == "y" then
        self:moveovertime( time )
    elseif type == "font" then
        self:changefontscaleovertime( time )
    else
        self:fadeovertime( time )
    end

    if(type == "x") then
        self.x = value;
    elseif(type == "y") then
        self.y = value;
    elseif(type == "alpha") then
        self.alpha = value;
    elseif(type == "color") then
        self.color = value;
    end
end