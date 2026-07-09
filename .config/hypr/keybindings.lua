---------------------
---- MY PROGRAMS ----
---------------------

-- Set default programs.
local terminal = 'ghostty'
local fileManager = 'nautilus'
local calculator = 'gnome-calculator'
local browser = 'brave-origin'
local mailClient = 'thunderbird'

local menu = 'dms ipc call spotlight toggle'
local notepad = 'dms ipc call notepad toggle'
local bottom = terminal .. ' --title=btm --confirm-close-surface=false -e btm'
local processes = 'dms ipc call processlist focusOrToggle'
local notifications = 'dms ipc call notifications toggle'
local powermenu = 'dms ipc call powermenu toggle'
local clipboard = 'dms ipc call clipboard toggle'
local lock = 'dms ipc call lock lock'
local settings = 'dms ipc call settings focusOrToggle'

---------------------
---- KEYBINDINGS ----
---------------------

local mod = 'SUPER' -- SUPER / Windows key

-- see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mod .. ' + COMMA', hl.dsp.exec_cmd(settings))
hl.bind(mod .. ' + RETURN', hl.dsp.exec_cmd(terminal))
hl.bind(mod .. ' + SLASH', hl.dsp.exec_cmd(notepad))
hl.bind(mod .. ' + SPACE', hl.dsp.exec_cmd(menu))
hl.bind(mod .. ' + B', hl.dsp.exec_cmd(bottom))
hl.bind(mod .. ' + M', hl.dsp.exec_cmd(processes))
hl.bind(mod .. ' + N', hl.dsp.exec_cmd(notifications))
hl.bind(mod .. ' + O', hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. ' + SHIFT + P', hl.dsp.exec_cmd(powermenu))
hl.bind(mod .. ' + V', hl.dsp.exec_cmd(clipboard))
hl.bind(mod .. ' + W', hl.dsp.exec_cmd(lock))

hl.bind(mod .. ' + Q', hl.dsp.window.close())
hl.bind(mod .. ' + D', hl.dsp.window.float { action = 'toggle' })
hl.bind(mod .. ' + F', hl.dsp.window.fullscreen { mode = 'maximized', action = 'toggle' })
hl.bind(mod .. ' + SHIFT + F', hl.dsp.window.fullscreen { mode = 'fullscreen', action = 'toggle' })
hl.bind(mod .. ' + I', hl.dsp.layout 'togglesplit') -- dwindle only

-- color picker & screenshot keybindings
hl.bind(mod .. ' + C', hl.dsp.exec_cmd 'dms color pick --autocopy')
hl.bind('PRINT', hl.dsp.exec_cmd 'dms screenshot')
hl.bind(mod .. ' + PRINT', hl.dsp.exec_cmd 'dms screenshot window')
hl.bind(mod .. ' + SHIFT + PRINT', hl.dsp.exec_cmd 'dms screenshot full')

-- Move focus with mod + arrow keys
hl.bind(mod .. ' + LEFT', hl.dsp.focus { direction = 'left' })
hl.bind(mod .. ' + RIGHT', hl.dsp.focus { direction = 'right' })
hl.bind(mod .. ' + UP', hl.dsp.focus { direction = 'up' })
hl.bind(mod .. ' + DOWN', hl.dsp.focus { direction = 'down' })
hl.bind(mod .. ' + H', hl.dsp.focus { direction = 'left' })
hl.bind(mod .. ' + L', hl.dsp.focus { direction = 'right' })
hl.bind(mod .. ' + K', hl.dsp.focus { direction = 'up' })
hl.bind(mod .. ' + J', hl.dsp.focus { direction = 'down' })

hl.bind(mod .. ' + TAB', hl.dsp.window.cycle_next())
hl.bind(mod .. ' + TAB', hl.dsp.window.bring_to_top())

hl.bind(mod .. ' + SHIFT + LEFT', hl.dsp.window.move { direction = 'left' })
hl.bind(mod .. ' + SHIFT + RIGHT', hl.dsp.window.move { direction = 'right' })
hl.bind(mod .. ' + SHIFT + UP', hl.dsp.window.move { direction = 'up' })
hl.bind(mod .. ' + SHIFT + DOWN', hl.dsp.window.move { direction = 'down' })
hl.bind(mod .. ' + SHIFT + H', hl.dsp.window.move { direction = 'left' })
hl.bind(mod .. ' + SHIFT + L', hl.dsp.window.move { direction = 'right' })
hl.bind(mod .. ' + SHIFT + K', hl.dsp.window.move { direction = 'up' })
hl.bind(mod .. ' + SHIFT + J', hl.dsp.window.move { direction = 'down' })

-- Switch workspaces with mod + [0-9]
-- Move active window to a workspace with mod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. ' + ' .. key, hl.dsp.focus { workspace = i })
    hl.bind(mod .. ' + SHIFT + ' .. key, hl.dsp.window.move { workspace = i })
end

-- Example special workspace (scratchpad)
hl.bind(mod .. ' + S', hl.dsp.workspace.toggle_special 'magic')
hl.bind(mod .. ' + SHIFT + S', hl.dsp.window.move { workspace = 'special:magic' })

-- Scroll through existing workspaces with mod + scroll
hl.bind(mod .. ' + mouse_down', hl.dsp.focus { workspace = 'e+1' })
hl.bind(mod .. ' + mouse_up', hl.dsp.focus { workspace = 'e-1' })

hl.bind(mod .. ' + ALT + RIGHT', hl.dsp.focus { workspace = 'e+1' })
hl.bind(mod .. ' + ALT + LEFT', hl.dsp.focus { workspace = 'e-1' })
hl.bind(mod .. ' + ALT + L', hl.dsp.focus { workspace = 'e+1' })
hl.bind(mod .. ' + ALT + H', hl.dsp.focus { workspace = 'e-1' })

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd 'dms ipc call audio increment 5', { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd 'dms ipc call audio decrement 5', { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd 'dms ipc call audio mute', { locked = true, repeating = true })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd 'dms ipc call audio micmute', { locked = true, repeating = true })

-- Music controls, requires playerctl
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd 'dms ipc call mpris playPause', { locked = true })
hl.bind('XF86AudioPause', hl.dsp.exec_cmd 'dms ipc call mpris playPause', { locked = true })
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd 'dms ipc call mpris previous', { locked = true })
hl.bind('XF86AudioNext', hl.dsp.exec_cmd 'dms ipc call mpris next', { locked = true })

-- Laptop multimedia keys for LCD brightness
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd 'dms ipc call brightness increment 5 ""', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd 'dms ipc call brightness decrement 5 ""', { locked = true, repeating = true })
hl.bind('XF86KbdBrightnessUp', hl.dsp.exec_cmd 'dms ipc call brightness increment 1 "leds:asus::kbd_backlight"', { locked = true, repeating = true })
hl.bind('XF86KbdBrightnessDown', hl.dsp.exec_cmd 'dms ipc call brightness decrement 1 "leds:asus::kbd_backlight"', { locked = true, repeating = true })

-- Special keys of apps
hl.bind('XF86Calculator', hl.dsp.exec_cmd(calculator))
hl.bind('XF86Explorer', hl.dsp.exec_cmd(fileManager))
hl.bind('XF86HomePage', hl.dsp.exec_cmd(browser))
hl.bind('XF86Mail', hl.dsp.exec_cmd(mailClient))
