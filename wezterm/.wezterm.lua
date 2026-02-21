local wezterm = require("wezterm")

local config = wezterm.config_builder()
--
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 20
--
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- my coolnight colorscheme
-- config.colors = {
-- foreground = "#CBE0F0",
-- background = "#011423",
-- cursor_bg = "#47FF9C",
-- cursor_border = "#47FF9C",
-- cursor_fg = "#011423",
-- selection_bg = "#033259",
-- selection_fg = "#CBE0F0",
-- ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }
config.colors = {
	foreground = "#c0caf5",
	background = "#1a1b26",
	cursor_bg = "#c0caf5",
	cursor_border = "#c0caf5",
	cursor_fg = "#1a1b26",
	selection_bg = "#283457",
	selection_fg = "#c0caf5",
	scrollbar_thumb = "#292e42",
	compose_cursor = "#ff9e64",
	split = "#7aa2f7",
	ansi = { "#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
	brights = { "#414868", "#ff899d", "#9fe044", "#faba4a", "#8db0ff", "#c7a9ff", "#a4daff", "#c0caf5" },
	tab_bar = {
		inactive_tab_edge = "#16161e",
		background = "#1a1b26",
		active_tab = {
			fg_color = "#16161e",
			bg_color = "#7aa2f7",
		},
		inactive_tab = {
			fg_color = "#545c7e",
			bg_color = "#292e42",
		},
		inactive_tab_hover = {
			fg_color = "#7aa2f7",
			bg_color = "#292e42",
		},
		new_tab = {
			fg_color = "#7aa2f7",
			bg_color = "#1a1b26",
		},
		new_tab_hover = {
			fg_color = "#7aa2f7",
			bg_color = "#1a1b26",
			intensity = "Bold",
		},
	},
}

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.98
config.macos_window_background_blur = 10

config.keys = {
	-- { key = "s", mods = "CMD", action = wezterm.action.SendString("\x13\x54") }, -- Cmd+K sends Ctrl+S followed by S
	-- New mapping for Ctrl + F (Ctrl + S followed by capital T)
	{ key = "f", mods = "CTRL", action = wezterm.action.SendString("\x13\x54") }, -- Ctrl+F sends Ctrl+S followed by Ctrl+T
	{ key = "1", mods = "CMD", action = wezterm.action.SendString("\x131") }, -- Cmd+1 sends Ctrl+S followed by 1
	{ key = "2", mods = "CMD", action = wezterm.action.SendString("\x132") }, -- Cmd+2 sends Ctrl+S followed by 2
	{ key = "3", mods = "CMD", action = wezterm.action.SendString("\x133") }, -- Cmd+3 sends Ctrl+S followed by 3
	{ key = "4", mods = "CMD", action = wezterm.action.SendString("\x134") }, -- Cmd+4 sends Ctrl+S followed by 4
	{ key = "5", mods = "CMD", action = wezterm.action.SendString("\x135") }, -- Cmd+5 sends Ctrl+S followed by 5
	{ key = "6", mods = "CMD", action = wezterm.action.SendString("\x136") }, -- Cmd+6 sends Ctrl+S followed by 6
	{ key = "7", mods = "CMD", action = wezterm.action.SendString("\x137") }, -- Cmd+7 sends Ctrl+S followed by 7
	{ key = "8", mods = "CMD", action = wezterm.action.SendString("\x138") }, -- Cmd+8 sends Ctrl+S followed by 8
	{ key = "9", mods = "CMD", action = wezterm.action.SendString("\x139") }, -- Cmd+9 sends Ctrl+S followed by 9
	{ key = "t", mods = "CMD", action = wezterm.action.SendString("\x13\x63") }, -- Cmd+T sends Ctrl+S followed by C
	{ key = "l", mods = "CMD", action = wezterm.action.SendString("\x13\x4c") }, -- Cmd+L sends Ctrl+S followed by L
	{ key = "h", mods = "CMD", action = wezterm.action.SendString("\x13\x48") }, -- Cmd+H sends Ctrl+S followed by H
	-- { key = "n", mods = "CMD", action = wezterm.action.SendString("\x13\x03") }, -- Cmd+N sends Ctrl+S followed by Ctrl+C
	{ key = "LeftArrow", mods = "CMD", action = wezterm.action.SendString("\x01") }, -- Cmd+Left → beginning of line (Ctrl+A)
	{ key = "RightArrow", mods = "CMD", action = wezterm.action.SendString("\x05") }, -- Cmd+Right → end of line (Ctrl+E)
}

return config
