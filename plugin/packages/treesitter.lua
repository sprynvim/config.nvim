local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = { "lua", "vimdoc", "bash", "css", "javascript", "html" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },  
})

require("nvim-treesitter.install").update({ with_sync = true })()
