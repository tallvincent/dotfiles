local wezterm = require("wezterm")
local utils = require("utils")
local module = {}

local function project_dotfiles(window, pane)
	local cwd = "~/dotfiles"
	return utils.workspace_single_pane(window, pane, "dotfiles", "cd " .. cwd .. " && vim .")
end

local function project_vmcr(window, pane)
	local cwd = "~/Documents/GitHub/valuemycards_rebirth"
	return utils.workspace_double_pane(window, pane, "Left", "VMCR", "cd " .. cwd, "cd " .. cwd .. " && vim .")
end

local function project_slbd_lcl(window, pane)
	local cwd = "/Applications/MAMP/htdocs/wordpress/wp-content/plugins/slbd-auto-card-scan"
	return utils.workspace_double_pane(
		window,
		pane,
		"Left",
		"SLBD LCL",
		"tail -f /Applications/MAMP/logs/php_error.log",
		"cd " .. cwd .. " && vim ."
	)
end

local function list_projects()
	return {
		vmcr = {
			label = wezterm.format({
				{ Foreground = { AnsiColor = "Red" } },
				{ Text = wezterm.nerdfonts.md_cards },
				{ Foreground = { AnsiColor = "White" } },
				{ Text = " Value My Cards Rebirth" },
			}),
			action = project_vmcr,
		},
		slbd_lcl = {
			label = wezterm.format({
				{ Foreground = { AnsiColor = "Blue" } },
				{ Text = wezterm.nerdfonts.fa_wordpress },
				{ Foreground = { AnsiColor = "White" } },
				{ Text = " Slabd Local Wordpress" },
			}),
			action = project_slbd_lcl,
		},
		dotfiles = {
			label = wezterm.format({
				{ Foreground = { AnsiColor = "Silver" } },
				{ Text = wezterm.nerdfonts.oct_gear },
				{ Foreground = { AnsiColor = "White" } },
				{ Text = " Dotfiles" },
			}),
			action = project_dotfiles,
		},
	}
end

function module.choose_project()
	local choices = {}
	for key, value in pairs(list_projects()) do
		table.insert(choices, { label = value.label, id = key })
	end
	table.sort(choices, function(a, b)
		return a.id < b.id
	end)

	return wezterm.action.InputSelector({
		title = "Projects",
		choices = choices,
		fuzzy = true,
		fuzzy_description = wezterm.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { Color = "#aaffaa" } },
			{ Text = "Enter a project name: " },
		}),
		action = wezterm.action_callback(function(window, pane, id, _label)
			if not id then
				return
			end
			local projects = list_projects()
			if not projects[id] then
				return
			end
			local project = projects[id].action
			return project(window, pane)
		end),
	})
end

-- Can be assigned directly to a key binding:
--   { mods="LEADER", key=",", action=projects.dotfiles() }
function module.dotfiles()
	return wezterm.action_callback(project_dotfiles)
end

return module
