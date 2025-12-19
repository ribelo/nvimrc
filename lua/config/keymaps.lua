-- Essential keymaps only

-- Better escape
vim.keymap.set("i", "jk", "<ESC>")

-- Don't yank with x
vim.keymap.set("n", "x", '"_x')

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window management
vim.keymap.set("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split vertical" })

-- Buffer management
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bs", "<cmd>write<CR>", { desc = "Save buffer" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move text up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Stay in center when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Lazy
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })