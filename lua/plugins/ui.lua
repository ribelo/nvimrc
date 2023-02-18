return {
  -- floating winbar
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      -- local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        -- highlight = {
        --   groups = {
        --     InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
        --     InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
        --   },
        -- },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local window = vim.api.nvim_win_get_number(props.win)
          ---@diagnostic disable-next-line: no-unknown
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return {
            { icon, guifg = color },
            { " " },
            { filename },
            { " " },
            {
              window,
            },
          }
        end,
      })
    end,
  },

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
    opts = {
      cursor = {
        enable = false,
      },
    },
  },

  -- auto-resize windows
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    keys = { { "<leader>Z", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },

  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      -- local colors = require("tokyonight.colors").setup()
      scrollbar.setup({
        -- handle = { color = colors.bg_highlight },
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
      })
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
      vim.pretty_print("opts", opts)
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
