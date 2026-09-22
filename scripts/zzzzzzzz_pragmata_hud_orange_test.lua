-- Experimental workaround: suppress one verified EffectTexture leaf only.
-- May remove the intended glow as well as corruption. No config changes.
local prefix='[PragmataHUDOrangeV1] '
local pending,counts,errors={},{},{}
local paths={'main/layout/offset/over/hackingGauge_VFX/effecttexture_'}
local function fail(key,msg)
    if not errors[key] then errors[key]=true;log.error(prefix..msg) end
end
local function restore(saved)
    for _,e in ipairs(saved or {}) do
        local ok,err=pcall(e.node.call,e.node,'set_Visible',e.visible)
        if not ok then fail('restore','restore error: '..tostring(err)) end
    end
end
re.on_pre_gui_draw_element(function(element)
    local key=element:get_address()
    local ok,err=pcall(function()
        local go=element:call('get_GameObject')
        if not go then return end
        local name=go:call('get_Name')
        if name~='ui2130Gui' then return end
        if pending[key] then return end
        local view=element:call('get_View')
        if not view then return end
        local saved={};pending[key]=saved
        for _,path in ipairs(paths) do
            local tag=name..':'..path
            local node=view:call('getObject',path)
            if node and node:get_type_definition():get_full_name()=='via.gui.EffectTexture' then
                local visible=node:call('get_Visible')
                if type(visible)~='boolean' then error('Unknown visibility at '..path) end
                if visible then
                    saved[#saved+1]={node=node,visible=visible}
                    node:call('set_Visible',false)
                end
                local n=counts[tag] or 0
                if n<4 then
                    counts[tag]=n+1
                    log.info(prefix..tag..' originalVisible='..tostring(visible)
                        ..' testVisible='..tostring(node:call('get_Visible')))
                end
            else fail(tag,name..' expected EffectTexture missing or mismatched at '..path..'; skipped') end
        end
    end)
    if not ok then restore(pending[key]);pending[key]=nil;fail('pre',tostring(err)) end
    return true
end)
re.on_gui_draw_element(function(element)
    local key=element:get_address();local saved=pending[key];pending[key]=nil;restore(saved)
end)
re.on_script_reset(function()
    for _,saved in pairs(pending) do restore(saved) end
    pending={}
end)
log.info(prefix..'loaded; ui2130 hackingGauge EffectTexture only; visibility restored after draw; experimental suppression')
