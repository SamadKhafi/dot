local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.enable_wayland = true
config.color_scheme = "tokyonight_night"
config.font = wezterm.font_with_fallback({
	{
		family = "Monaspace Radon",
		weight = "Regular",
		harfbuzz_features = {
			"calt",
			"ss01",
			"ss02",
			"ss03",
			"ss04",
			"ss05",
			"ss06",
			"ss07",
			"ss08",
			"ss09",
			"liga",
		},
	},
	{
		family = "JetBrains Mono",
	},
})
config.font_size = 12.0
config.line_height = 1.3
config.freetype_load_target = "Light"

config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

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
