local comments = require("nvim_comment")

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

comments.setup({
  comment_empty = false,
  -- line_mapping = "<leader>cl",
  -- operator_mapping = "<leader>/",
  create_mappings = false,
  hook = function()
    require('ts_context_commentstring').update_commentstring()
  end,
})
