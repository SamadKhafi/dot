local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = "tokyonight_night"
config.font_size = 12.0
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Catppuccin Macchiato"
-- config.color_scheme = "GitHub Dark"

config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Catppuccin Mocha theme for tab bar
config.colors = {
	tab_bar = {
		background = "#313244",
		active_tab = {
			bg_color = "#1e1e2e",
			fg_color = "#f5e0dc",
		},
		inactive_tab = {
			bg_color = "#45475a",
			fg_color = "#a6adc8",
		},
		inactive_tab_hover = {
			bg_color = "#585b70",
			fg_color = "#cdd6f4",
		},
		new_tab = {
			bg_color = "#313244",
			fg_color = "#bac2de",
		},
		new_tab_hover = {
			bg_color = "#585b70",
			fg_color = "#cdd6f4",
		},
	},
}

return config
