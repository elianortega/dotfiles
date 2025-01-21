local wezterm = require("wezterm")

local config = wezterm.config_builder()
--
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19
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
config.window_background_opacity = 0.90
config.macos_window_background_blur = 10

-- config.mouse_bindings = {
-- 	-- CMD-click will open the link under the mouse cursor
-- 	{
-- 		event = { Up = { streak = 1, button = "Left" } },
-- 		mods = "SUPER",
-- 		action = wezterm.action.OpenLinkAtMouseCursor,
-- 	},
-- }
--
-- wezterm.on("open-uri", function(window, pane, uri)
-- 	wezterm.log_info(window)
-- 	wezterm.log_info(pane)
-- 	wezterm.log_info(uri)
-- end)

return config
