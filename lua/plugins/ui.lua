return {
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
