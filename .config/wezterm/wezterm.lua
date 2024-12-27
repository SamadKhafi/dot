local wezterm = require("wezterm")

local hashtag = ("#"):byte()
local function half_color(hex)
	if hex:byte() == hashtag then
		hex = hex:sub(2)
	end

	local r = math.floor(tonumber(hex:sub(1, 2), 16) / 2)
	local g = math.floor(tonumber(hex:sub(3, 4), 16) / 2)
	local b = math.floor(tonumber(hex:sub(5, 6), 16) / 2)

	return ("#%02X%02X%02X"):format(r, g, b)
end

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
local font_family = "JetBrains Mono"

config.enable_wayland = true
config.color_scheme = "tokyonight_night"
config.font_size = 12.0
config.line_height = 1.25
config.freetype_load_target = "Light"
config.font_rules = {
	{
		intensity = "Half",
		font = wezterm.font(font_family, {
			foreground = half_color("#c0caf5"),
		}),
	},
}

config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.animation_fps = 120
config.max_fps = 120

-- tokyonight_night theme for tab bar
config.colors = {
	tab_bar = {
		background = "#292e42",
		active_tab = {
			bg_color = "#1a1b26",
			fg_color = "#c0caf5",
		},
		inactive_tab = {
			bg_color = "#414868",
			fg_color = "#a9b1d6",
		},
		inactive_tab_hover = {
			bg_color = "#545c7e",
			fg_color = "#c0caf5",
		},
		new_tab = {
			bg_color = "#292e42",
			fg_color = "#bb9af7",
		},
		new_tab_hover = {
			bg_color = "#545c7e",
			fg_color = "#c0caf5",
		},
	},
}

return config
