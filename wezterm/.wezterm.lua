local wezterm = require("wezterm")

local config = wezterm.config_builder()
--
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19
--
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- my coolnight colorscheme
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
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
