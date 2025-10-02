if not _G._mason_setup then
	require("mason").setup()
	_G._mason_setup = true
end

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"eslint",
		"tailwindcss",
		"html",
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

vim.filetype.add({
  extension = {
    edge = 'edge'
  }
})

local lspconfig = require("lspconfig")
vim.lsp.enable('lua_ls')

vim.lsp.config.html = {
  filetypes = { 'html', 'edge' },
  init_options = {
    provideFormatter = true
  }
}

vim.lsp.enable('html')

vim.lsp.config.ts_ls = {
	filetypes = { "javascript", "typescript" },
}

vim.lsp.enable('ts_ls')

vim.lsp.enable('eslint')

vim.lsp.config('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },

  -- Add 'edge' to filetypes Tailwind should run on
  filetypes = {
    'html', 'edge', 'javascript', 'javascriptreact',
    'typescript', 'typescriptreact', 'vue', 'svelte',
  },

  -- Map Edge → HTML so Tailwind understands it
  init_options = {
    userLanguages = {
      edge = 'html',
    },
  },

  root_markers = {
    'package.json',
    'tailwind.config.js', 'tailwind.config.cjs',
    'tailwind.config.ts', 'tailwind.config.mjs',
    '.git',
  },

  settings = {
    tailwindCSS = {
      includeLanguages = { edge = 'html' },
      experimental = {
        classRegex = {
          -- Put your dynamic class regexes here if you need them
          -- { 'class:\\s*"([^"]*)"', 1 },
          -- { 'class=\\{`([^`}]+)`\\}', 1 },
          -- { 'tw`([^`]*)`', 1 },
        },
      },
    },
  },
})

vim.lsp.enable('tailwindcss')

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

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
	},
})

require("edge").setup({
  indent_width = 2,
})
