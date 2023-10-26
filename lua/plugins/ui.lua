return {
  {
    "echasnovski/mini.indentscope",
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "clojure", "fennel" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },

  {
    "echasnovski/mini.animate",
    enabled = true,
    event = "VeryLazy",
    opts = {
      cursor = {
        enable = false,
      },
      resize = {
        enable = false,
      },
      open = {
        enable = false,
      },
      close = {
        enable = false,
      },
      scroll = {
        enable = not vim.g.neovide,
      },
    },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "gruvbox-material"
      table.insert(opts.sections.lualine_x, {
        function()
          return require("util.dashboard").status()
        end,
      })
      table.insert(opts.sections.lualine_z, {
        function()
          return vim.api.nvim_win_get_number(0)
        end,
      })
    end,
  },
  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
      config = {
        header = {
          [[                                        ]],
          [[                                        ]],
          [[                                        ]],
          [[                                        ]],
          [[<-. (`-')_      (`-')  _     <-. (`-')  ]],
          [[   \( OO) )    _(OO ) (_)       \(OO )_ ]],
          [[,--./ ,--/,--.(_/,-.\ ,-(`-'),--./  ,-.)]],
          [[|   \ |  |\   \ / (_/ | ( OO)|   `.'   |]],
          [[|  . '|  |)\   /   /  |  |  )|  |'.'|  |]],
          [[|  |\    |_ \     /_)(|  |_/ |  |   |  |]],
          [[|  | \   |\-'\   /    |  |'->|  |   |  |]],
          [[`--'  `--'    `-'     `--'   `--'   `--']],
          [[                                        ]],
          [[                                        ]],
          [[                                        ]],
          [[                                        ]],
        },
      },
    },
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
}
