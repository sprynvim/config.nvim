if not _G._mason_setup then
	require("mason").setup()
	_G._mason_setup = true
end
require("mason-nvim-dap").setup()
local dap = require("dap")
-- local dap_utils = require("dap.utils")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

local exts = {
	"javascript",
	"typescript",
}

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

-- Dap Virtual Text
dap_virtual_text.setup()

-- Configurations
for i, ext in ipairs(exts) do
	dap.configurations[ext] = {
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Node.js",
			port = 9222,
			skipFiles = { "<node_internals>/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
	}
end

-- Dap UI

ui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 1.0 },
			},
			size = 40, -- width of the left panel
			position = "left",
		},
		-- You can omit the bottom layout entirely if not needed
	},
	-- Optional: Don't open other UI elements
	controls = { enabled = false },
	floating = { max_height = nil, max_width = nil },
})

vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)

-- configure widgets

-- local widgets = require("dap.ui.widgets")

-- set scopes as right pane
-- local scopes = widgets.sidebar(widgets.scopes, {}, "vsplit")


dap.listeners.before.attach.dapui_config = function()
	ui.open()
	-- scopes.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
	-- scopes.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
	-- scopes.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
	-- scopes.close()
end

vim.keymap.set("n", "<leader>dt", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint", nowait = true, remap = false })

vim.keymap.set("n", "<leader>dn", function()
	require("dap").clear_breakpoints()
end, { desc = "Clear all Breakpoints", nowait = true, remap = false })

vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Continue", nowait = true, remap = false })

vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Step Into", nowait = true, remap = false })

vim.keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "Step Over", nowait = true, remap = false })

vim.keymap.set("n", "<leader>du", function()
	require("dap").step_out()
end, { desc = "Step Out", nowait = true, remap = false })

vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end, { desc = "Open REPL", nowait = true, remap = false })

vim.keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end, { desc = "Run Last", nowait = true, remap = false })

vim.keymap.set("n", "<leader>dq", function()
	require("dap").terminate()
	-- require("dapui").close()
	require("nvim-dap-virtual-text").toggle()
end, { desc = "Terminate", nowait = true, remap = false })

vim.keymap.set("n", "<leader>db", function()
	require("dap").list_breakpoints()
end, { desc = "List Breakpoints", nowait = true, remap = false })

vim.keymap.set("n", "<leader>de", function()
	require("dap").set_exception_breakpoints({ "all" })
end, { desc = "Set Exception Breakpoints", nowait = true, remap = false })
