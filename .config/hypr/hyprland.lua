-- https://wiki.hypr.land/Configuring/Start/

----------------------
------ MONITORS ------
----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor { output = 'HDMI-A-1', mode = '1920x1080@60', position = 'auto', scale = 1 }
hl.monitor { output = 'eDP-1', mode = '1920x1080@120', position = 'auto', scale = 1 }

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on('hyprland.start', function()
    hl.exec_cmd '/usr/lib/hyprpolkitagent/hyprpolkitagent'
    hl.exec_cmd 'dms run -d'
    hl.exec_cmd 'valent --gapplication-service'
    hl.exec_cmd 'bash -c "wl-paste --watch cliphist store &"'
    hl.exec_cmd 'hyprctl setcursor MacTahoe-dark-cursors 24'
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env('GTK_USE_PORTAL', '1')
hl.env('QT_QPA_PLATFORM', 'wayland')
hl.env('QT_QPA_PLATFORMTHEME', 'gtk3')
hl.env('QT_QPA_PLATFORMTHEME_QT6', 'gtk3')
hl.env('ELECTRON_OZONE_PLATFORM_HINT', 'auto')

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config {
    general = {
        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = 'dwindle',
    },

    decoration = {
        rounding_power = 3,

        active_opacity = 0.9,
        inactive_opacity = 0.7,
        fullscreen_opacity = 1.0,

        dim_inactive = true,
        dim_strength = 0.3,

        shadow = {
            enabled = false,
            range = 30,
            render_power = 5,
            offset = { 0, 5 },
            color = 0x70000000,
        },

        blur = {
            enabled = true,
            size = 8,
            passes = 3,

            noise = 0.02,
            brightness = 0.9,
            contrast = 1.1,
            vibrancy = 0.2,
            vibrancy_darkness = 0.3,
        },
    },

    animations = {
        enabled = true,
    },
}

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve('easeOutQuint', { type = 'bezier', points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve('easeInOutCubic', { type = 'bezier', points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve('linear', { type = 'bezier', points = { { 0, 0 }, { 1, 1 } } })
hl.curve('almostLinear', { type = 'bezier', points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve('quick', { type = 'bezier', points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve('easy', { type = 'spring', mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation { leaf = 'global', enabled = true, speed = 10, bezier = 'default' }
hl.animation { leaf = 'border', enabled = true, speed = 5.39, bezier = 'easeOutQuint' }
hl.animation { leaf = 'windows', enabled = true, speed = 4.79, spring = 'easy' }
hl.animation { leaf = 'windowsIn', enabled = true, speed = 4.1, spring = 'easy', style = 'popin 87%' }
hl.animation { leaf = 'windowsOut', enabled = true, speed = 1.49, bezier = 'linear', style = 'popin 87%' }
hl.animation { leaf = 'fadeIn', enabled = true, speed = 1.73, bezier = 'almostLinear' }
hl.animation { leaf = 'fadeOut', enabled = true, speed = 1.46, bezier = 'almostLinear' }
hl.animation { leaf = 'fade', enabled = true, speed = 3.03, bezier = 'quick' }
hl.animation { leaf = 'layers', enabled = true, speed = 3.81, bezier = 'easeOutQuint' }
hl.animation { leaf = 'layersIn', enabled = true, speed = 4, bezier = 'easeOutQuint', style = 'fade' }
hl.animation { leaf = 'layersOut', enabled = true, speed = 1.5, bezier = 'linear', style = 'fade' }
hl.animation { leaf = 'fadeLayersIn', enabled = true, speed = 1.79, bezier = 'almostLinear' }
hl.animation { leaf = 'fadeLayersOut', enabled = true, speed = 1.39, bezier = 'almostLinear' }
hl.animation { leaf = 'workspaces', enabled = true, speed = 1.94, bezier = 'almostLinear', style = 'fade' }
hl.animation { leaf = 'workspacesIn', enabled = true, speed = 1.21, bezier = 'almostLinear', style = 'fade' }
hl.animation { leaf = 'workspacesOut', enabled = true, speed = 1.94, bezier = 'almostLinear', style = 'fade' }
hl.animation { leaf = 'zoomFactor', enabled = true, speed = 7, bezier = 'quick' }

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config {
    dwindle = {
        preserve_split = true,
    },
}

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config {
    master = {
        new_status = 'master',
    },
}

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config {
    scrolling = {
        fullscreen_on_one_column = true,
    },
}

----------------
----  MISC  ----
----------------

hl.config {
    misc = {
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true,
    },
}

require 'inputs'
require 'keybindings'

-- DankMaterialShell
require 'dms.colors'
require 'dms.cursor'
require 'dms.layout'
require 'dms.outputs'

require 'windowrules'
require 'layerrules'
