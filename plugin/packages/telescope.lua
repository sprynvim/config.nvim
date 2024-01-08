local keymap = vim.keymap
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local themes = require("telescope.themes")

telescope.setup({
  defaults = {
    path_display = { "truncate" },
    mappings = {
      n = {
        ["<C-d>"] = actions.delete_buffer,
      },
      i = {
        ["<C-d>"] = actions.delete_buffer,
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
    extensions = {
      ["ui-select"] = {
        themes.get_dropdown({})
      }
    },
  },
})

keymap.set('n', '<leader>ff', builtin.git_files, { desc = "Find Files in Git Repo" })
keymap.set('n', '<leader>fd', builtin.find_files, { desc = "Find Files in cwd" })
keymap.set('n', '<leader>fc', builtin.grep_string, { desc = "Search string under cursor in cwd" })
keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "List previously open files" })
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep in cwd" })
keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Find Keymaps" })
keymap.set('n', '<leader>cs', builtin.colorscheme, { desc = "Colorschemes" })
keymap.set('n', '<space>e', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { desc = "File Explorer", noremap = true })

telescope.load_extension("ui-select")
telescope.load_extension("file_browser")
