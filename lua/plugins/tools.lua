return {
  { "rktjmp/paperplanes.nvim", opts = {
    provider_options = {
      expires = 24,
    },
  } },
  {
    "nvim-orgmode/orgmode",
    version = false,
    config = function()
      ---@diagnostic disable-next-line: no-unknown
      local orgmode = require("orgmode")
      orgmode.setup_ts_grammar()
      orgmode.setup()
    end,
  },
  {
    "TimUntersberger/neogit",
    config = true,
    keys = {
      {
        "<leader>gn",
        function()
          require("neogit").open()
        end,
      },
    },
  },
  { "kevinhwang91/rnvimr", keys = { { "<leader>R", ":RnvimrToggle<CR>" } } },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>op",
        function()
          ---@diagnostic disable-next-line: no-unknown
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    opts = { theme = "light" },
  },
  "tpope/vim-fugitive",
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*", "!lazy" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },
}
