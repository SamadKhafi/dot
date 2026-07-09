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

-- make bitwarden extension float and center
hl.window_rule { match = { title = '_crx_nngceckbapebfimnlniiiahkandclblb' }, float = true }
hl.window_rule { match = { title = '_crx_nngceckbapebfimnlniiiahkandclblb' }, center = true }
hl.window_rule { match = { title = '_crx_nngceckbapebfimnlniiiahkandclblb' }, size = '400 640' }
hl.window_rule { match = { title = '_crx_nngceckbapebfimnlniiiahkandclblb' }, animation = 'popin' }
-- bitwarden dynamic rules
hl.window_rule { match = { title = '^(Bitwarden)$' }, border_size = 2 }
hl.window_rule { match = { title = '^(Bitwarden)$' }, border_color = 'rgb(eeeeee) rgb(cccccc)' }
hl.window_rule { match = { title = '^(Bitwarden)$' }, no_dim = true }
hl.window_rule { match = { title = '^(Bitwarden)$' }, opacity = '1.0 override 1.0 override 1.0 override' }

-- make calculator float and center.
hl.window_rule { float = true, match = { title = '^(Calculator)$' } }
hl.window_rule { center = true, match = { title = '^(Calculator)$' } }
hl.window_rule { size = '400 640', match = { title = '^(Calculator)$' } }
hl.window_rule { animation = 'popin', match = { title = '^(Calculator)$' } }
-- calculator dynamic rules.
hl.window_rule { border_size = 2, match = { title = '^(Calculator)$' } }
hl.window_rule { border_color = 'rgb(eeeeee) rgb(cccccc)', match = { title = '^(Calculator)$' } }
hl.window_rule { no_dim = true, match = { title = '^(Calculator)$' } }
hl.window_rule { opacity = '1.0 override 1.0 override 1.0 override', match = { title = '^(Calculator)$' } }

hl.window_rule { float = true, match = { title = '^(About Mozilla Firefox)$' } }
hl.window_rule { float = true, match = { class = '^(firefox)$', title = '^(Picture-in-Picture)$' } }
hl.window_rule { float = true, match = { class = '^(firefox)$', title = '^(Library)$' } }
hl.window_rule { float = true, match = { class = '^(vlc)$' } }
hl.window_rule { float = true, match = { class = '^(kvantummanager)$' } }
hl.window_rule { float = true, match = { class = '^(qt5ct)$' } }
hl.window_rule { float = true, match = { class = '^(qt6ct)$' } }
hl.window_rule { float = true, match = { class = '^(org.pulseaudio.pavucontrol)$' } }
hl.window_rule { float = true, match = { class = '^(blueman-manager)$' } }
hl.window_rule { float = true, match = { class = '^(nm-applet)$' } }
hl.window_rule { float = true, match = { class = '^(nm-connection-editor)$' } }
hl.window_rule { float = true, match = { class = '^(io.missioncenter.MissionCenter)$' } } -- MissionCenter-Gtk

hl.window_rule { float = true, match = { class = '^(com.mitchellh.ghostty)$', title = '^(top)$' } }
hl.window_rule { float = true, match = { class = '^(com.mitchellh.ghostty)$', title = '^(btm)$' } }
hl.window_rule { float = true, match = { class = '^(com.mitchellh.ghostty)$', title = '^(btop)$' } }
hl.window_rule { float = true, match = { class = '^(com.mitchellh.ghostty)$', title = '^(htop)$' } }
hl.window_rule { center = true, match = { class = '^(com.mitchellh.ghostty)$', title = '^(top)$' } }
hl.window_rule { center = true, match = { class = '^(com.mitchellh.ghostty)$', title = '^(btm)$' } }
hl.window_rule { center = true, match = { class = '^(com.mitchellh.ghostty)$', title = '^(btop)$' } }
hl.window_rule { center = true, match = { class = '^(com.mitchellh.ghostty)$', title = '^(htop)$' } }
hl.window_rule { size = '1366 768', match = { class = '^(com.mitchellh.ghostty)$', title = '^(top)$' } }
hl.window_rule { size = '1366 768', match = { class = '^(com.mitchellh.ghostty)$', title = '^(btm)$' } }
hl.window_rule { size = '1366 768', match = { class = '^(com.mitchellh.ghostty)$', title = '^(btop)$' } }
hl.window_rule { size = '1366 768', match = { class = '^(com.mitchellh.ghostty)$', title = '^(htop)$' } }

hl.window_rule { float = true, match = { class = '^(popup.app)$' } }
hl.window_rule { center = true, match = { class = '^(popup.app)$' } }
hl.window_rule { size = '50% 50%', match = { class = '^(popup.app)$' } }
hl.window_rule { pin = true, match = { class = '^(popup.app)$' } }
hl.window_rule { stay_focused = true, match = { class = '^(popup.app)$' } }
hl.window_rule { animation = 'popin', match = { class = '^(popup.app)$' } }

-- common modals
hl.window_rule { float = true, match = { title = '^(Open)$' } }
hl.window_rule { float = true, match = { title = '^(Choose Files)$' } }
hl.window_rule { float = true, match = { title = '^(Save As)$' } }
hl.window_rule { float = true, match = { title = '^(Confirm to replace files)$' } }
hl.window_rule { float = true, match = { title = '^(File Operation Progress)$' } }
hl.window_rule { float = true, match = { class = '^(xdg-desktop-portal-gtk)$' } }
