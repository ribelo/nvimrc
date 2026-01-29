return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
      },
    },
  },
}
