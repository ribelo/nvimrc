-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.backup = true
  vim.opt.cmdheight = 0
  vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
end

if vim.g.neovide then
  vim.opt.guifont = { "JetBrainsMono Nerd Font", "h9" }
  vim.g.neovide_scale_factor = 0.5
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0
end

-- vim.opt.numberwidth = 2
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
