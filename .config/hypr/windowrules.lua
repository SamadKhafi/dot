--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule {
    -- Fix some dragging issues with XWayland
    name = 'fix-xwayland-drags',
    match = {
        class = '^$',
        title = '^$',
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
}

-- disable opacity for browsers
hl.window_rule {
    name = 'opaque-brave',
    match = { class = 'brave-(browser|origin)' },

    no_dim = true,
    opacity = '1.0 override 1.0 override 1.0 override',
}

hl.window_rule {
    name = 'opaque-chrome',
    match = { class = 'google-chrome' },

    opacity = '1.0 override 0.7 override 1.0 override',
}

-- youtube picture-in-picture mode.
hl.window_rule {
    match = { title = '^(Picture-in-picture)$' },

    content = 'video',
    float = true,
    pin = true,
    no_initial_focus = true,
    size = '400 240',
    move = 'monitor_w-408 monitor_h-300',
    animation = 'popin',
    border_size = 2,
    border_color = 'rgb(eeeeee) rgb(cccccc)',
    no_dim = true,
    opacity = '1.0 override 1.0 override 1.0 override',
}

-- make bitwarden extension float and center
hl.window_rule {
    match = { title = '_crx_nngceckbapebfimnlniiiahkandclblb' },

    float = true,
    center = true,
    size = '480 640',
    animation = 'popin',
}
-- bitwarden dynamic rules
hl.window_rule {
    match = { title = '^(Bitwarden)$' },

    border_size = 2,
    border_color = 'rgb(eeeeee) rgb(cccccc)',
    no_dim = true,
    opacity = '1.0 override 1.0 override 1.0 override',
}

-- gnome calculator.
hl.window_rule {
    match = { title = '^(Calculator)$' },

    -- make calculator float and center.
    float = true,
    center = true,
    size = '400 640',
    animation = 'popin',

    -- calculator dynamic rules.
    border_size = 2,
    border_color = 'rgb(eeeeee) rgb(cccccc)',
    no_dim = true,
    opacity = '1.0 override 1.0 override 1.0 override',
}

hl.window_rule { float = true, match = { class = '^(org.quickshell)$' } }
hl.window_rule { float = true, match = { title = '^(About Mozilla Firefox)$' } }
hl.window_rule { float = true, match = { class = '^(firefox)$', title = '^(Picture-in-Picture)$' } }
hl.window_rule { float = true, match = { class = '^(firefox)$', title = '^(Library)$' } }
hl.window_rule { float = true, match = { class = '^(kvantummanager)$' } }
hl.window_rule { float = true, match = { class = '^(qt5ct)$' } }
hl.window_rule { float = true, match = { class = '^(qt6ct)$' } }
hl.window_rule { float = true, match = { class = '^(blueman-manager)$' } }
hl.window_rule { float = true, match = { class = '^(nm-applet)$' } }
hl.window_rule { float = true, match = { class = '^(nm-connection-editor)$' } }

hl.window_rule {
    match = { class = '^(com.mitchellh.ghostty)$', title = '^(top|btm|btop|htop)$' },

    float = true,
    center = true,
    size = '1366 768',
}

hl.window_rule {
    match = { class = '^(popup.app)$' },

    float = true,
    center = true,
    size = '50% 50%',
    pin = true,
    stay_focused = true,
    animation = 'popin',
}

-- common modals
hl.window_rule { float = true, match = { title = '^(Open)$' } }
hl.window_rule { float = true, match = { title = '^(Choose Files)$' } }
hl.window_rule { float = true, match = { title = '^(Save As)$' } }
hl.window_rule { float = true, match = { title = '^(Confirm to replace files)$' } }
hl.window_rule { float = true, match = { title = '^(File Operation Progress)$' } }
hl.window_rule { float = true, match = { class = '^(xdg-desktop-portal-gtk)$' } }
