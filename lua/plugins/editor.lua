return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      -- keep empty: install parsers manually when you actually need them
      ensure_installed = {},
      auto_install = false,
    },
  },

  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },
}
