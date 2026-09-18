-- v12: loot left/down 199 units; enemy raised 149.25 units from v11.
-- Reference: current stamina width = 398 * 0.75 * 2 = 597 units.
-- Move health right and weapon left 59.7 units: 20% of 398 * 0.75 stamina width.
-- Raise health and weapon groups 13.5 layout units; stamina retains its v6 height.
-- Shift all display layers left 298.5 layout units from v3: three quarters the logged 398-unit stamina width.
-- Display-layer XY scaling around estimated widget centers. Preserve Z; translate hacking views right without scaling.
-- Native REFramework already restores these views to Screen after drawing.
local targets = {
    ui2120Gui={x=-199,y=199,factor=1,ax=0,ay=0},
    ui3400Gui={x=597,y=149.25,factor=1,ax=0,ay=0,path="view"},
    ui3500Gui={x=298.5,y=0,factor=1,ax=0,ay=0,path="view"},
    ui3510Gui={x=298.5,y=0,factor=1,ax=0,ay=0,path="view"},
    ui2130Gui={x=-38.8, y=-273.5, factor=0.75, ax=173.85, ay=942},
    ui2140Gui={x=-478.5, y=-260, factor=0.75, ax=960, ay=980},
    ui2150Gui={x=-818.2, y=-213.5, factor=0.50, ax=1661, ay=874},
}
local screen_targets = {ui2121Gui=true,ui2131Gui=true, ui2141Gui=true, ui2151Gui=true}
local pending = {}
local counts = {}
local prefix = "[PragmataHUDV12]"
re.on_pre_gui_draw_element(function(element)
    local ok, err = pcall(function()
        local go = element:call("get_GameObject")
        if not go then return end
        local name = tostring(go:call("get_Name"))
        if not targets[name] and not screen_targets[name] then return end
        local view = element:call("get_View")
        if not view then return end
        -- Original values verified in native post-restoration diagnostic.
        if screen_targets[name] then
            view:call("set_ViewType", 0)
            view:call("set_Detonemap", false)
            if not counts[name] then log.info(prefix .. " " .. name .. " preserved Screen mode"); counts[name]=1 end
            return
        end
        local key = element:get_address()
        local offset = targets[name]
        local capture = offset.path == "view" and view or view:call("getObject", "main/layout/offset")
        if capture and not pending[key] then
            local pos = capture:call("get_Position")
            local scale = capture:call("get_Scale")
            pending[key] = {obj=capture, x=pos.x, y=pos.y, z=pos.z,
                sx=scale.x, sy=scale.y, sz=scale.z}
            pos.x = pos.x + offset.x + scale.x * (1-offset.factor) * offset.ax
            pos.y = pos.y + offset.y + scale.y * (1-offset.factor) * offset.ay
            scale.x, scale.y = scale.x * offset.factor, scale.y * offset.factor
            capture:call("set_Scale", scale)
            capture:call("set_Position", pos)
        end
        local count = counts[name] or 0
        if count < 4 then
            log.info(prefix .. " " .. name .. " Screen=" .. tostring(view:call("get_ViewType"))
                .. " Detonemap=" .. tostring(view:call("get_Detonemap"))
                .. " displayLayerFound=" .. tostring(capture ~= nil) .. " offset=" .. offset.x .. "," .. offset.y .. " sizeFactor=" .. offset.factor)
            counts[name] = count + 1
        end
    end)
    if not ok then log.error(prefix .. " " .. tostring(err)) end
end)
re.on_gui_draw_element(function(element)
    local key = element:get_address()
    local saved = pending[key]
    if not saved then return end
    pending[key] = nil
    local ok, err = pcall(function()
        local scale = saved.obj:call("get_Scale")
        scale.x, scale.y, scale.z = saved.sx, saved.sy, saved.sz
        saved.obj:call("set_Scale", scale)
        local pos = saved.obj:call("get_Position")
        pos.x, pos.y, pos.z = saved.x, saved.y, saved.z
        saved.obj:call("set_Position", pos)
    end)
    if not ok then log.error(prefix .. " restore: " .. tostring(err)) end
end)
log.info(prefix .. " loaded; display-layer offsets; preserve original screen mode on four companion views")
