local keymap = vim.keymap

-- Save buffer with CTRL+s
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save current buffer in normal mode." })
keymap.set("i", "<C-s>", "<Esc>:w<CR>l ", { desc = "Save current buffer in insert mode." })
keymap.set("x", "<C-s>", "<Esc>:w<CR> ", { desc = "Save current buffer in visual mode." })
keymap.set("n", "<C-a>", ":wa<CR>", { desc = "Save all current buffers in normal mode." })
keymap.set("i", "<C-a>", "<Esc>:wa<CR>l ", { desc = "Save all current buffers in insert mode." })
keymap.set("x", "<C-a>", "<Esc>:wa<CR> ", { desc = "Save all current buffers in visual mode." })

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
keymap.set("n", "<leader>ct", ":bd!<CR>", { desc = "Quit and Close Terminal" })

-- Tab management
keymap.set("n", "<C-t>", ":tabe<CR>", { desc = "New tab." })
keymap.set("n", "<C-k>", ":tabfirst<CR>", { desc = "Move to first tab." })
keymap.set("n", "<C-j>", ":tablast<CR>", { desc = "Move to last tab." })
keymap.set("n", "<C-h>", ":tabp<CR>", { desc = "Move to previous tab." })
keymap.set("n", "<C-l>", ":tabn<CR>", { desc = "Move to next tab." })
keymap.set("n", "<C-x>", ":tabdo | q<CR>", { desc = "Close all tabs and quit." })
keymap.set("n", "<leader>m", ":tabc<CR>", { desc = "Close this tab." })
keymap.set("n", "<leader>mo", ":tabo<CR>", { desc = "Close other tabs." })
vim.keymap.set("n", "!", ":tabn 1<CR>", { desc = "Move to first tab." })
vim.keymap.set("n", "@", ":tabn 2<CR>", { desc = "Move to second tab." })
vim.keymap.set("n", "#", ":tabn 3<CR>", { desc = "Move to third tab." })
vim.keymap.set("n", "$", ":tabn 4<CR>", { desc = "Move to fourth tab." })
vim.keymap.set("n", "%", ":tabn 5<CR>", { desc = "Move to fifth tab." })
