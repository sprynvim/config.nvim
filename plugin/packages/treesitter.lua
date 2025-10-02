local configs = require("nvim-treesitter.configs")
local vim = vim

configs.setup({
  ensure_installed = { "lua", "vimdoc", "bash", "css", "javascript", "html" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})

vim.treesitter.language.register('html', 'edge')

require("nvim-treesitter.install").update({ with_sync = true })()
