-- Pull in the wezterm API
local wezterm = require("wezterm")
local projects = require("projects")
local utils = require("utils")
-- This will hold the configuration
local config = wezterm.config_builder()
local act = wezterm.action

wezterm.on("update-status", function(window, _pane)
	window:set_right_status("workspace: " .. window:active_workspace())
end)

-- Color scheme
-- config.color_scheme = "Kanagawa (Gogh)"
config.color_scheme = "catppuccin-frappe"
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
	-- Cmd-click will open the link under the mouse cursor
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
	{ key = "p", mods = "LEADER", action = projects.choose_project() },
	-- Open dotfiles directory in a new workspace
	{ key = ",", mods = "LEADER", action = projects.dotfiles() },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
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
	{
		key = "w",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
}

config.key_tables = {
	copy_mode = {
		{
			key = "L",
			mods = "NONE",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{
			key = "L",
			mods = "SHIFT",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{
			key = "H",
			mods = "NONE",
			action = act.CopyMode("MoveToStartOfLine"),
		},
		{
			key = "H",
			mods = "SHIFT",
			action = act.CopyMode("MoveToStartOfLine"),
		},
		{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{
			key = "Tab",
			mods = "SHIFT",
			action = act.CopyMode("MoveBackwardWord"),
		},
		{
			key = "Enter",
			mods = "NONE",
			action = act.CopyMode("MoveToStartOfNextLine"),
		},
		{
			key = "Escape",
			mods = "NONE",
			action = act.Multiple({
				{ CopyMode = "MoveToScrollbackBottom" },
				{ CopyMode = "Close" },
			}),
		},
		{
			key = "Space",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Cell" }),
		},
		{
			key = "$",
			mods = "NONE",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{
			key = "$",
			mods = "SHIFT",
			action = act.CopyMode("MoveToEndOfLineContent"),
		},
		{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
		{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
		{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
		{
			key = "F",
			mods = "NONE",
			action = act.CopyMode({ JumpBackward = { prev_char = false } }),
		},
		{
			key = "F",
			mods = "SHIFT",
			action = act.CopyMode({ JumpBackward = { prev_char = false } }),
		},
		{
			key = "G",
			mods = "NONE",
			action = act.CopyMode("MoveToScrollbackBottom"),
		},
		{
			key = "G",
			mods = "SHIFT",
			action = act.CopyMode("MoveToScrollbackBottom"),
		},
		{
			key = "M",
			mods = "NONE",
			action = act.CopyMode("MoveToViewportMiddle"),
		},
		{
			key = "M",
			mods = "SHIFT",
			action = act.CopyMode("MoveToViewportMiddle"),
		},
		{
			key = "O",
			mods = "NONE",
			action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
		},
		{
			key = "O",
			mods = "SHIFT",
			action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
		},
		{
			key = "T",
			mods = "NONE",
			action = act.CopyMode({ JumpBackward = { prev_char = true } }),
		},
		{
			key = "T",
			mods = "SHIFT",
			action = act.CopyMode({ JumpBackward = { prev_char = true } }),
		},
		{
			key = "V",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Line" }),
		},
		{
			key = "V",
			mods = "SHIFT",
			action = act.CopyMode({ SetSelectionMode = "Line" }),
		},
		{
			key = "^",
			mods = "NONE",
			action = act.CopyMode("MoveToStartOfLineContent"),
		},
		{
			key = "^",
			mods = "SHIFT",
			action = act.CopyMode("MoveToStartOfLineContent"),
		},
		{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{
			key = "c",
			mods = "CTRL",
			action = act.Multiple({
				{ CopyMode = "MoveToScrollbackBottom" },
				{ CopyMode = "Close" },
			}),
		},
		{
			key = "d",
			mods = "CTRL",
			action = act.CopyMode({ MoveByPage = 0.5 }),
		},
		{
			key = "e",
			mods = "NONE",
			action = act.CopyMode("MoveForwardWordEnd"),
		},
		{
			key = "f",
			mods = "NONE",
			action = act.CopyMode({ JumpForward = { prev_char = false } }),
		},
		{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		{
			key = "g",
			mods = "NONE",
			action = act.CopyMode("MoveToScrollbackTop"),
		},
		{
			key = "g",
			mods = "CTRL",
			action = act.Multiple({
				{ CopyMode = "MoveToScrollbackBottom" },
				{ CopyMode = "Close" },
			}),
		},
		{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
		{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
		{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
		{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
		{
			key = "m",
			mods = "ALT",
			action = act.CopyMode("MoveToStartOfLineContent"),
		},
		{
			key = "o",
			mods = "NONE",
			action = act.CopyMode("MoveToSelectionOtherEnd"),
		},
		{
			key = "q",
			mods = "NONE",
			action = act.Multiple({
				{ CopyMode = "MoveToScrollbackBottom" },
				{ CopyMode = "Close" },
			}),
		},
		{
			key = "t",
			mods = "NONE",
			action = act.CopyMode({ JumpForward = { prev_char = true } }),
		},
		{
			key = "u",
			mods = "CTRL",
			action = act.CopyMode({ MoveByPage = -0.5 }),
		},
		{
			key = "v",
			mods = "NONE",
			action = act.CopyMode({ SetSelectionMode = "Cell" }),
		},
		{
			key = "v",
			mods = "CTRL",
			action = act.CopyMode({ SetSelectionMode = "Block" }),
		},
		{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
		{
			key = "y",
			mods = "NONE",
			action = act.Multiple({
				{ CopyTo = "ClipboardAndPrimarySelection" },
				{ CopyMode = "MoveToScrollbackBottom" },
				{ CopyMode = "Close" },
			}),
		},
	},
}

-- Return the configuration to wezterm
return config
