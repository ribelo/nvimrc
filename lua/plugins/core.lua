-- * override the configuration of LazyVim plugins
return {
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  { "folke/lazy.nvim", version = false },
  { "LazyVim/LazyVim", version = false },
}
