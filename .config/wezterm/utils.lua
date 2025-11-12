local wezterm = require("wezterm")
local module = {}

function module.workspace_single_pane(window, _pane, workspace, command)
	local _, pane, _ = wezterm.mux.spawn_window({
		workspace = workspace,
	})
	pane:activate()
	pane:send_text(command .. "\n")
	return window:perform_action(
		wezterm.action.SwitchToWorkspace({
			name = workspace,
		}),
		pane
	)
end

function module.workspace_double_pane(window, pane, direction, workspace, command1, command2)
	local _, pane_bottom, _ = wezterm.mux.spawn_window({
		workspace = workspace,
	})
	local pane_top = pane_bottom:split({
		direction = direction or "Top",
		size = 0.3,
	})
	pane_bottom:activate()
	pane_top:send_text(command1 .. "\n")
	pane_bottom:send_text(command2 .. "\n")
	return window:perform_action(
		wezterm.action.SwitchToWorkspace({
			name = workspace,
		}),
		pane
	)
end

return module
