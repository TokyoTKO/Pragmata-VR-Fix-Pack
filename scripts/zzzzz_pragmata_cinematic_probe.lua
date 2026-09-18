-- Cinematic side-mask test 2: skip only the observed ui0420Gui mask.
-- No transform edits. Other fades, menus and HUD elements remain untouched.
local prefix="[PragmataSideMask2]"
local reported,error_reported=false,false
re.on_pre_gui_draw_element(function(element)
    local ok,matched=pcall(function()
        local go=element:call("get_GameObject")
        if not go or tostring(go:call("get_Name"))~="ui0420Gui" then return false end
        local view=element:call("get_View")
        if not view then return false end
        local left=view:call("getObject","main/layout/L/rect")
        local right=view:call("getObject","main/layout/R/rect")
        if not left or not right then return false end
        if not reported then
            log.info(prefix.." suppressing ui0420Gui; observed L/rect and R/rect confirmed")
            reported=true
        end
        return true
    end)
    if not ok then
        if not error_reported then log.error(prefix.." "..tostring(matched));error_reported=true end
        return
    end
    if matched then return false end
end)
log.info(prefix.." loaded; targeted ui0420Gui side-mask suppression")
