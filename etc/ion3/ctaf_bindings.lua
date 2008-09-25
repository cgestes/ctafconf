-- ctaf's bindings: these allow you to navigate ion in a sane way.
--

defbindings("WScreen", {
    kpress("Mod4+Shift+Left", "WScreen.switch_prev(_)"),
    kpress("Mod4+Shift+Right", "WScreen.switch_next(_)"),

    kpress("Mod4+Shift+Up", "WScreen.switch_prev(_)"),
    kpress("Mod4+Shift+Down", "WScreen.switch_next(_)"),


    kpress("Mod1+Tab", "ioncore.goto_next(_chld, 'prev')", "_chld:non-nil"),
    kpress("Mod4+Up", "ioncore.goto_next(_chld, 'prev')", "_chld:non-nil"),
    kpress("Mod1+Shift+Tab", "ioncore.goto_next(_chld, 'next')", "_chld:non-nil"),
    kpress("Mod4+Down", "ioncore.goto_next(_chld, 'next')", "_chld:non-nil"),

    kpress("Mod4+R", "ioncore.restart()"),
--    kpress("Mod4+Control+Up", "ioncore.goto_next(_chld, 'top')", "_chld:non-nil"),
--    kpress("Mod4+Control+Down", "ioncore.goto_next(_chld, 'bottom')", "_chld:non-nil"),
})

defbindings("WGroupCW", {
    bdoc("Toggle client window group full-screen mode"),
    kpress_wait("Mod4+Return", "WGroup.set_fullscreen(_, 'toggle')"),
})


defbindings("WFrame", {
    kpress("Mod4+Left", "WFrame.switch_prev(_)"),
    kpress("Mod4+Right", "WFrame.switch_next(_)"),
})


defbindings("WInput", {
    bdoc("Close the query/message box, not executing bound actions."),
    kpress("Mod4+G", "WInput.cancel(_)"),
})

-- Frames for transient windows ignore this bindmap
defbindings("WMPlex.toplevel", {
    bdoc("launch nautilus"),
    kpress(ALTMETA.."F5", "ioncore.exec_on(_, 'nautilus --no-desktop')"),

    bdoc("launch epiphany"),
    kpress(ALTMETA.."F6", "ioncore.exec_on(_, 'epiphany')"),

    bdoc("launch thunderbird"),
    kpress(ALTMETA.."F7", "ioncore.exec_on(_, 'thunderbird')"),

    bdoc("launch totem"),
    kpress(ALTMETA.."F8", "ioncore.exec_on(_, 'totem')"),

})

