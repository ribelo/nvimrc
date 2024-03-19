return {
  "mbbill/undotree",
  "folke/twilight.nvim",
  "lambdalisue/suda.vim",
  "clojure-vim/vim-jack-in",
  "tpope/vim-dispatch",
  "radenling/vim-dispatch-neovim",
  { "NMAC427/guess-indent.nvim", config = true },

  {
    dir = "/home/ribelo/projects/nvim_plugins/table.nvim/",
  },

  {

    dir = "/home/ribelo/projects/nvim_plugins/taskwarrior.nvim/",
    -- "ribelo/taskwarrior.nvim",
    -- enabled = false,
    event = "BufReadPost",
    opts = {},
    keys = {
      {
        "<leader>tw",
        ":Task ",
      },
      {
        "<leader>sT",
        function()
          require("taskwarrior_nvim").browser({ "ready" })
        end,
        desc = "Task Browser",
      },
      {
        "<leader>tC",
        function()
          require("taskwarrior_nvim").go_to_config_file()
        end,
        desc = "Task config file",
      },
    },
  },

  {
    dir = "/home/ribelo/projects/nvim_plugins/pareto.nvim/",
    keys = {
      {
        "<m-l>",
        function()
          require("pareto_nvim").forward_sexp()
        end,
        mode = { "n", "i" },
      },
      {
        "<m-h>",
        function()
          require("pareto_nvim").backward_sexp()
        end,
        mode = { "n", "i" },
      },
      {
        "<c-m-l>",
        function()
          require("pareto_nvim").forward_slurp()
        end,
        mode = { "n", "i" },
      },
      {
        "<c-m-h>",
        function()
          require("pareto_nvim").forward_barf()
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
          require("pareto_nvim").raise_node()
        end,
      },
      {
        "<localleader>@",
        function()
          require("pareto_nvim").splice_node()
        end,
      },
      {
        "|",
        function()
          require("pareto_nvim").split_node()
        end,
      },
    },
  },

  {
    -- "ribelo/prompter.nvim",
    dir = "/home/ribelo/projects/nvim_plugins/prompter.nvim/",
    keys = {
      { "<leader>cp", ":PrompterBrowser<cr>", mode = { "n", "x" }, desc = "Prompter browser" },
    },
    config = true,
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
    version = false,
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
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },
}
