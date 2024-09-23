require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"html",
		"lua_ls",
		"ts_ls",
		"eslint",
		"tailwindcss",
	},
})

-- INSTALL NON LSP SERVERS (FORMATTERS and LINTERS)
local registry = require("mason-registry")

for _, pkg_name in ipairs({ "stylua" }) do
	local ok, pkg = pcall(registry.get_package, pkg_name)
	if ok then
		if not pkg:is_installed() then
			pkg:install()
		end
	end
end

local vim = vim
local lspconfig = require("lspconfig")
lspconfig.html.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.lua_ls.setup({})
lspconfig.ts_ls.setup({
	filetypes = { "javascript", "typescript" },
})
lspconfig.eslint.setup({})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.tidy,
	},
})

local keymap = vim.keymap
keymap.set("n", "K", vim.lsp.buf.hover, {})
keymap.set("n", "gd", vim.lsp.buf.definition, {})
keymap.set("n", "gi", vim.lsp.buf.implementation, {})
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, {})
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
keymap.set("n", "gr", vim.lsp.buf.references, {})
keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, {})
