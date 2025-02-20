-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()
local act = wezterm.action

-- Color scheme
config.color_scheme = "Kanagawa (Gogh)"
config.font = wezterm.font("JetBrains Mono")

config.window_background_opacity = 1.0
config.macos_window_background_blur = 30
-- config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.window_decorations = "RESIZE"
-- config.enable_tab_bar = false
-- TODO: function to only show tab bar on keypress or when switching tabs
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.adjust_window_size_when_changing_font_size = false

config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.OpenLinkAtMouseCursor,
	},
}

config.leader = {
	key = "a",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}

-- Key remaps
config.keys = {
	{ key = "v", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	-- Pane switching
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	-- Toggle zoom for current pane
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	-- Tabs
	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },
	{
		key = "R",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Open .wezterm.lua with Cmd + ,
	-- {
	-- 	key = ",",
	-- 	mods = "LEADER",
	-- 	action = act.SpawnCommandInNewTab({
	-- 		cwd = os.getenv("WEZTERM_CONFIG_DIR"),
	-- 		set_environment_variables = {
	-- 			TERM = "screen-256color",
	-- 		},
	-- 		args = {
	-- 			"/opt/homebrew/bin/nvim",
	-- 			os.getenv("WEZTERM_CONFIG_FILE"),
	-- 		},
	-- 	}),
	-- },
}

-- Return the configuration to wezterm
return config
