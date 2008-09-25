META="Mod1+"
ALTMETA="Mod4+"

-- Terminal emulator
XTERM="gnome-terminal"

-- Some basic settings
ioncore.set{
    -- Maximum delay between clicks in milliseconds to be considered a
    -- double click.
    --dblclick_delay=250,

    mousefocus='sloppy',

    -- For keyboard resize, time (in milliseconds) to wait after latest
    -- key press before automatically leaving resize mode (and doing
    -- the resize in case of non-opaque move).
    --kbresize_delay=1500,

    -- Opaque resize?
    opaque_resize=true,

    -- Movement commands warp the pointer to frames instead of just
    -- changing focus. Enabled by default.
    --warp=true,

    -- Switch frames to display newly mapped windows
    --switchto=true,

    -- Default index for windows in frames: one of 'last', 'next' (for
    -- after current), or 'next-act' (for after current and anything with
    -- activity right after it).
    --frame_default_index='next-act',

    -- Auto-unsqueeze transients/menus/queries.
    unsqueeze=true,

    -- Display notification tooltips for activity on hidden workspace.
    screen_notify=true,
}




dopath("cfg_defaults")
dopath("cfg_ioncore")
dopath("look_greenlight")

dopath("cfg_mouse")

dopath("ctaf_bindings")
--dopath("emacs_bindings")
