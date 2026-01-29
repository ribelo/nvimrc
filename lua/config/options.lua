-- Options (keep it simple)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- LazyVim
vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_blink_main = false

-- disable netrw (neo-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- use system clipboard by default
vim.opt.clipboard = "unnamedplus"

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"

vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = false

-- backup files (handy on NixOS too)
if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.backup = true
  vim.opt.cmdheight = 0
  vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
end

-- neovide quality-of-life
if vim.g.neovide then
  vim.opt.guifont = "JetBrainsMono Nerd Font:h13"
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0

  vim.keymap.set("v", "<C-S-C>", '"+y') -- Copy
  vim.keymap.set("n", "<C-S-V>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<C-S-V>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<C-S-V>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<C-S-V>", '<ESC>l"+Pli') -- Paste insert mode
end

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
