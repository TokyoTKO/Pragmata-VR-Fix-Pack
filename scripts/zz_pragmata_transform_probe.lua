-- v3: suppress hacking target brackets and HUD decoration in every view mode.
-- Replaces the Screen-mode experiment. No view-mode or transform setters.
-- Keep the accepted zzzz_pragmata_capture_screen_test.lua installed unchanged.
local prefix = "[PragmataTargetHideV3]"
local hidden = {ui3203Gui=true, ui2160Gui=true}
local reported = {}
local error_reported = false
re.on_pre_gui_draw_element(function(element)
    local ok, name = pcall(function()
        local go = element:call("get_GameObject")
        return go and tostring(go:call("get_Name")) or ""
    end)
    if not ok then
        if not error_reported then
            log.error(prefix .. " name lookup failed: " .. tostring(name))
            error_reported = true
        end
        return
    end
    if not hidden[name] then return end
    if not reported[name] then
        reported[name] = true
        log.info(prefix .. " suppressing " .. name .. " in all view modes")
    end
    -- Skip the draw for every matching instance, eye, and Screen/World mode.
    -- REFramework still runs its normal post-draw restoration callbacks.
    return false
end)
log.info(prefix .. " loaded; brackets and decoration hidden; accepted HUD layout unchanged")
