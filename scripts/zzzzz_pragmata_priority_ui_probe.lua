-- Priority test 5: extend the accepted companion-view Screen-mode fix.
-- No layout scaling/position changes. Replaces the disabled test-3 script.
local targets={ui2101Gui=true,ui2111Gui=true}
local counts,errors={},{}
local prefix="[PragmataPriorityCompanion5]"
re.on_pre_gui_draw_element(function(element)
    local ok,err=pcall(function()
        local go=element:call("get_GameObject")
        if not go then return end
        local name=tostring(go:call("get_Name"))
        if not targets[name] then return end
        local view=element:call("get_View")
        if not view then return end
        local before=view:call("get_ViewType")
        view:call("set_ViewType",0)
        view:call("set_Detonemap",false)
        local count=counts[name] or 0
        if count<6 then
            counts[name]=count+1
            log.info(prefix.." "..name.." before="..tostring(before)
                .." after="..tostring(view:call("get_ViewType"))
                .." Detonemap="..tostring(view:call("get_Detonemap")))
        end
    end)
    if not ok and not errors.pre then
        log.error(prefix.." "..tostring(err));errors.pre=true
    end
end)
log.info(prefix.." loaded; Screen-mode correction for ui2101Gui and ui2111Gui only")
