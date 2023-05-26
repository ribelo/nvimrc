-- * override the configuration of LazyVim plugins
return {
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      colorscheme = "gruvbox-material",
      icons = {
        diagnostics = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        },
      },
    },
  },
  { "folke/lazy.nvim", version = false },
  { "LazyVim/LazyVim", version = false },
}
