local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  install = { colorscheme = { "gruvbox-material", "habamax" } },
  checker = { enabled = true },
  performance = {
    cache = { enabled = true },
    rtp = {
      paths = { vim.fn.stdpath("data") .. "/site" },
      disabled_plugins = {
        "netrwPlugin",
        "tohtml",
        "tutor",
      },
    },
  },
})
