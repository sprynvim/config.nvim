local keymap = vim.keymap

-- Save buffer with CTRL+s
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save current buffer in normal mode." })
keymap.set("i", "<C-s>", "<Esc>:w<CR>l ", { desc = "Save current buffer in insert mode." })
keymap.set("x", "<C-s>", "<Esc>:w<CR> ", { desc = "Save current buffer in visual mode." })

-- Switch between tabs and spaces
keymap.set("n", "<leader>us", ":set et<CR>", { desc = "Use spaces" })
keymap.set("n", "<leader>ut", ":set noet<CR>", { desc = "Use tabs" })

-- Run macros
keymap.set("n", "Q", "@qj")
keymap.set("x", "Q", ":norm @q<CR>")

-- Stay in Visual mode on indent
keymap.set("x", ">", ">gv")
keymap.set("x", "<", "<gv")

-- Esc to clear last search highlighting
keymap.set("n", "<Esc>", ":noh<CR>", { noremap = true, desc = "Clear last search highlighting" })

-- Show Diagnostics
keymap.set("n", "<leader>D", ":Telescope diagnostics bufnr=0<CR>")
keymap.set("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>")
keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>")
keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>")

-- Comment Lines
keymap.set("n", "<leader>/", ":CommentToggle<CR>", { noremap = true })
keymap.set("x", "<leader>/", ":'<,'>CommentToggle<CR>", { noremap = true })

-- Window management
keymap.set("n", "<leader>nv", ":vnew<CR>", { desc = "New vertical split" })
keymap.set("n", "<leader>nh", ":new<CR>", { desc = "New horizontal split" })
keymap.set("n", "<leader>wh", ":wincmd h<CR>", { desc = "Move cursor to window at left" })
keymap.set("n", "<leader>wj", ":wincmd j<CR>", { desc = "Move cursor to window below" })
keymap.set("n", "<leader>wk", ":wincmd k<CR>", { desc = "Move cursor to window above" })
keymap.set("n", "<leader>wl", ":wincmd l<CR>", { desc = "Move cursor to window at right" })
keymap.set("n", "<leader>wq", ":q<CR>", { desc = "Close window" })
