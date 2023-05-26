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

  -- style windows with different colorschemes
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    opts = {
      themes = {
        -- markdown = { colorscheme = "tokyonight-storm" },
        -- help = { colorscheme = "oxocarbon", background = "dark" },
      },
    },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "gruvbox-material"
      table.remove(opts.sections.lualine_c, 1) -- remove diagnostics
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
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
<-. (`-')_      (`-')  _     <-. (`-')  
   \( OO) )    _(OO ) (_)       \(OO )_ 
,--./ ,--/,--.(_/,-.\ ,-(`-'),--./  ,-.)
|   \ |  |\   \ / (_/ | ( OO)|   `.'   |
|  . '|  |)\   /   /  |  |  )|  |'.'|  |
|  |\    |_ \     /_)(|  |_/ |  |   |  |
|  | \   |\-'\   /    |  |'->|  |   |  |
`--'  `--'    `-'     `--'   `--'   `--'
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
