return {
  "folke/twilight.nvim",
  "lambdalisue/suda.vim",
  "dhruvasagar/vim-table-mode",
  "akinsho/org-bullets.nvim",
  "lukas-reineke/headlines.nvim",
  "clojure-vim/clojure.vim",
  "clojure-vim/vim-jack-in",
  -- "guns/vim-sexp",
  "tpope/vim-fugitive",
  "tpope/vim-dispatch",
  "radenling/vim-dispatch-neovim",
  "dhruvasagar/vim-table-mode",
  "windwp/nvim-ts-autotag",

  {
    "ribelo/pareto.nvim",
    keys = {
      {
        "<m-l>",
        function()
          require("pareto_nvim").forward_node()
        end,
        mode = { "n", "i" },
      },
      {
        "<m-h>",
        function()
          require("pareto_nvim").backward_node()
        end,
        mode = { "n", "i" },
      },
      {
        "<localleader>ww",
        function()
          require("pareto_nvim").wrap_node("(")
        end,
      },
      {
        "<localleader>wW",
        function()
          require("pareto_nvim").wrap_node(")")
        end,
      },
      {
        "<localleader>w[",
        function()
          require("pareto_nvim").wrap_node("[")
        end,
      },
      {
        "<localleader>w]",
        function()
          require("pareto_nvim").wrap_node("]")
        end,
      },
      {
        "<localleader>w{",
        function()
          require("pareto_nvim").wrap_node("{")
        end,
      },
      {
        "<localleader>w}",
        function()
          require("pareto_nvim").wrap_node("}")
        end,
      },
      {
        "<localleader>i",
        function()
          require("pareto_nvim").jump_parent_begin()
        end,
      },
      {
        "<localleader>I",
        function()
          require("pareto_nvim").jump_parent_end()
        end,
      },
      {
        "<localleader>o",
        function()
          require("pareto_nvim").splice_node()
        end,
      },
    },
  },

  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "andymass/vim-matchup",
    enabled = true,
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  {
    "s1n7ax/nvim-window-picker",
    opts = {
      selection_chars = "WESDUIOJKL",
      other_win_hl_color = "#BF616A",
      use_winbar = "always",
      show_prompt = false,
    },
    keys = {
      {
        "<leader>ww",
        function()
          local win_id = require("window-picker").pick_window()
          if type(win_id) == "number" then
            vim.api.nvim_set_current_win(win_id)
          end
        end,
      },
    },
  },

  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", ":UndotreeShow<CR>:UndotreeFocus<CR>" },
    },
  },

  {
    "dense-analysis/neural",
    enabled = true,
    opts = {
      mappings = {
        swift = "<c-x><c-s>",
      },
      open_ai = {
        api_key = vim.fn.systemlist("echo $OPENAI_API_KEY")[1],
      },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },
  {
    -- TODO:
    "anuvyklack/hydra.nvim",
  },

  {
    "NMAC427/guess-indent.nvim",
    config = true,
  },

  {
    "folke/trouble.nvim",
    opts = {
      icons = false,
      signs = {
        error = "E",
        warning = "W",
      },
    },
  },
}
