return {
  -- { "tpope/vim-fugitive" },
  { "rktjmp/paperplanes.nvim", opts = {
    provider_options = {
      expires = 24,
    },
  } },
  {
    "NeogitOrg/neogit",
    -- branch = "nightly",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },

    opts = {
      disable_commit_confirmation = true,
      auto_show_console = false,
      integrations = {
        diffview = false,
        fzf_lua = true,
      },
    },
    config = true,
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
}
