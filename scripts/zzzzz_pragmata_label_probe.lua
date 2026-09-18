-- V13: retain ui3010 Overlay=false; main title branch alpha=1, original RGB.
-- Preserve RGB, background branch, NEW strip, transforms and other GUIs.
-- This can remove the main title fade while its visibility flag is true.
-- Only apply when 'name' is the sole visible direct child of the item panel.
local prefix='[PragmataLabelOpacity13] '
local pending,logged={},{}
local draws,samples=0,0
local function once(key,msg)
    if not logged[key] then logged[key]=true;log.info(prefix..msg) end
end
local function fmt(v)
    return string.format('%.5g,%.5g,%.5g,%.5g',v.x,v.y,v.z,v.w)
end
local function restore(saved)
    if not saved then return end
    local ok,err=pcall(saved.panel.call,saved.panel,'set_ColorScale',saved.original)
    if not ok then once('restoreError','RESTORE ERROR '..tostring(err)) end
end
re.on_pre_gui_draw_element(function(element)
    local key=element:get_address()
    local ok,err=pcall(function()
        local go=element:call('get_GameObject')
        if not go or go:call('get_Name')~='ui3010Gui' then return end
        if pending[key] then return end
        local view=element:call('get_View')
        if not view then return end
        view:call('set_Overlay',false)
        local panel=view:call('getObject','main/layout/type/item')
        if not panel or panel:get_type_definition():get_full_name()~='via.gui.Panel' then
            once('missing','Main title panel missing; no brightness edit');return
        end
        local child=panel:call('get_Child')
        local count,found=0,false
        while child do
            count=count+1
            if count>32 then once('limit','Child limit exceeded; no brightness edit');return end
            local visible=child:call('get_Visible')
            if type(visible)~='boolean' then error('Unknown child visibility; brightness skipped') end
            if visible then
                local name=child:call('get_Name')
                if name~='name' or child:get_type_definition():get_full_name()~='via.gui.Text' then
                    once('other:'..tostring(name),'Other visible child '..tostring(name)..'; brightness skipped to protect non-title content')
                    return
                end
                found=true
            end
            child=child:call('get_Next')
        end
        if not found then return end
        local original=panel:call('get_ColorScale')
        for _,k in ipairs({'x','y','z','w'}) do
            local n=original[k]
            if type(n)~='number' or n~=n or math.abs(n)==math.huge then error('Invalid ColorScale') end
        end
        local saved=Vector4f.new(original.x,original.y,original.z,original.w)
        pending[key]={panel=panel,original=saved}
        local brighter=Vector4f.new(original.x,original.y,original.z,1)
        panel:call('set_ColorScale',brighter)
        draws=draws+1
        if samples<12 and (draws==1 or draws%90==0) then
            samples=samples+1
            local after=panel:call('get_ColorScale')
            local matches=math.abs(after.x-brighter.x)<0.0001 and math.abs(after.y-brighter.y)<0.0001
                and math.abs(after.z-brighter.z)<0.0001 and math.abs(after.w-brighter.w)<0.0001
            log.info(prefix..'sample='..samples..' draw='..draws..' before={'..fmt(saved)..'} requested={'..fmt(brighter)..'} after={'..fmt(after)
                ..'} opacityApplied='..tostring(matches)
                ..' mixed={'..fmt(panel:call('get_ColorScaleMixed'))..'}'
                ..' Overlay='..tostring(view:call('get_Overlay'))..' Detonemap='..tostring(view:call('get_Detonemap')))
        end
    end)
    if not ok then
        restore(pending[key]);pending[key]=nil;once('error','ERROR '..tostring(err))
    end
    return true
end)
re.on_gui_draw_element(function(element)
    local key=element:get_address();local saved=pending[key];pending[key]=nil;restore(saved)
end)
re.on_script_reset(function()
    for _,saved in pairs(pending) do restore(saved) end
    pending={}
end)
log.info(prefix..'loaded; main title alpha=1 test; RGB preserved; original colour scale restored after draw')
