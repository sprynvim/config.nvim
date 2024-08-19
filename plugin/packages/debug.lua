local dap = require("dap")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")

local function getNpmScripts()
	local packageJsonPath = vim.fn.getcwd() .. "/package.json"
	local content = vim.fn.readfile(packageJsonPath)

	if not content or vim.fn.empty(content) == 1 then
		print("package.json not found or empty")
		return {}
	end

	local packageJson = vim.fn.json_decode(table.concat(content, "\n"))

	if not packageJson or not packageJson.scripts then
		print("No scripts found in package.json")
		return {}
	end

	local scripts = {}
	for scriptName, _ in pairs(packageJson.scripts) do
		table.insert(scripts, scriptName)
	end

	return scripts
end

local function preLaunchNpmTask()
	local npmScripts = getNpmScripts()

	if #npmScripts == 0 then
		print("No npm scripts available.")
		return
	end

	pickers
		.new({}, {
			prompt_title = "Select an npm script",
			finder = finders.new_table({
				results = npmScripts,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					local selectedScript = selection[1]

					if selectedScript == "debug" then
						vim.cmd("10split | terminal npm run " .. selectedScript)
						vim.cmd("wincmd k")
						vim.cmd("DapContinue")
					end

					if selectedScript == "dev" then
						vim.cmd("10split | terminal npm run " .. selectedScript)
						vim.cmd("wincmd k")
					end
				end)
				return true
			end,
		})
		:find()
end

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = { os.getenv("HOME") .. "/Development/js-debug/src/dapDebugServer.js", "${port}" },
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach to Node.js",
		protocol = "inspector",
		port = 9222,
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		skipFiles = { "<node_internals>/**" },
		restart = true,
	},
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",  -- This points to the current file in Neovim
    cwd = vim.fn.getcwd(),  -- The current working directory
    sourceMaps = true,  -- Enable source maps for better debugging
    protocol = "inspector",  -- Use the "inspector" protocol
    console = "integratedTerminal",  -- Use the integrated terminal for output
    resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },  -- Source map resolution
  },
}

-- dap.configurations.typescript = dap.configurations.javascript

vim.keymap.set("n", "<leader>sd", preLaunchNpmTask)
vim.keymap.set("n", "<leader>sp", require("dap").continue)
vim.keymap.set("n", "<leader>sl", require("dap").step_over)
vim.keymap.set("n", "<leader>sj", require("dap").step_into)
vim.keymap.set("n", "<leader>si", require("dap").step_out)
vim.keymap.set("n", "<leader>sb", require("dap").toggle_breakpoint)

require('telescope').load_extension('dap')

vim.keymap.set("n", "<leader>lb", ":Telescope dap list_breakpoints<CR>")
vim.keymap.set("n", "<leader>lc", ":Telescope dap commands<CR>")
vim.keymap.set("n", "<leader>lv", ":Telescope dap variables<CR>")
vim.keymap.set("n", "<leader>lf", ":Telescope dap configurations<CR>")
