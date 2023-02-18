-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local m = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  colorcolumn = "99999",
  foldmethod = "manual",
  foldexpr = "",
  foldlevel = 99,
  foldlevelstart = 99,
  foldenable = true,
  foldcolumn = "0",
  hidden = true,
  title = true,
  completeopt = "menuone,noselect",
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 100,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  numberwidth = 2,
  signcolumn = "yes",
  wrap = false,
  linebreak = true,
  spell = false,
  spelllang = "pl",
  scrolloff = 8,
  sidescrolloff = 8,
  incsearch = true,
  equalalways = false,
  guifont = "JetBrainsMono Nerd Font:h8",
}

for k, v in pairs(m) do
  ---@diagnostic disable-next-line: no-unknown
  vim.o[k] = v
end

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell/"
-- vim.opt.shortmess = vim.opt.shortmess .. "c"
