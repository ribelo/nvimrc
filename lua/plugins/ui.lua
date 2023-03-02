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
          local filename_icon, filename_color = require("nvim-web-devicons").get_icon_color(filename)

          ---@param hl string
          ---@param type? string
          local function get_color(hl, type)
            if not type then
              type = "foreground"
            end
            if props.focused then
              return string.format("#%06x", vim.api.nvim_get_hl_by_name(hl, true)[type])
            else
              return
            end
          end

          local function get_diagnostics()
            local order = { "Error", "Warn", "Info", "Hint" }
            local icons = require("lazyvim.config").icons.diagnostics
            local label = {}
            for _, type in ipairs(order) do
              local icon = icons[type]
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(type)] })
              if n > 0 then
                local fg = get_color("DiagnosticSign" .. type)
                table.insert(label, { icon .. " " .. n .. " ", guifg = fg })
              end
            end
            return label
          end

          ---@param x any
          ---@param y? any
          local function when_focused(x, y)
            if props.focused then
              return x
            else
              return y
            end
          end

          local diagnostics = get_diagnostics()
          local renderer = {
            { filename_icon, guifg = filename_color },
            { " " },
            {
              filename,
              gui = when_focused("italic"),
              guifg = get_color("Yellow"),
            },
            { " | ", guifg = get_color("NonText") },
            {
              window,
              gui = when_focused("italic"),
              guifg = get_color("Yellow"),
            },
          }

          if #diagnostics > 0 then
            for i, label in ipairs(diagnostics) do
              table.insert(renderer, i, label)
            end
            table.insert(renderer, #diagnostics + 1, { "| ", guifg = get_color("NonText") })
          end

          return renderer
        end,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics_indicator = false,
      },
    },
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
