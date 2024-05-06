return {
  "chaoren/vim-wordmotion",
  {
    "kkharji/sqlite.lua",
    enabled = function()
      return not jit.os:find("Windows")
    end,
    config = function()
      local path = vim.fn.systemlist("echo $SQLITE_PATH")[1]
      -- local path = "/nix/store/fmh3s032bcsbfcdp82zsjlmkj1kp72j6-sqlite-3.43.1/lib/libsqlite3.so"
      vim.cmd(string.format(
        [[
        let g:sqlite_clib_path = '%s'
        ]],
        path
      ))
    end,
  },

  -- better increase/descrease
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
        desc = "Increment",
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
        desc = "Decrement",
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%H:%M"],
          augend.date.alias["%H:%M:%S"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.misc.alias.markdown_header,
        },
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      label = {
        after = false,
        before = true,
      },
      modes = {
        search = {
          enabled = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "Olical/conjure",
    lazy = false,
    config = function()
      vim.cmd([[
      let g:conjure#extract#tree_sitter#enabled = 1
      let g:conjure#eval#inline#highlight = "Special"
      let g:conjure#highlight#enabled = 1
      let g:conjure#highlight#timeout = 250
      let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = 0
      let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = ""
      let g:conjure#mapping#def_str = v:false
      let g:conjure#mapping#def_word = v:false
      let g:conjure#mapping#doc_word = v:false
      let g:conjure#mapping#doc_word = v:false
      let g:conjure#mapping#def_word = v:false
      ]])
      vim.keymap.set("x", "<localleader>E", ":WhichKey ,<cr>", {})
    end,
  },
  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.style = {
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      }
      local borderstyle = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        scrollbar = "║",
        winhighlight = "NormalFloat:Normal,FloatBorder:CmpMenuBorder",
      }
      opts.window = {
        completion = borderstyle,
        documentation = borderstyle,
      }
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-x><C-f>"] = cmp.mapping.complete({ config = { sources = { { name = "path" } } } }),
        ["<C-x><C-o>"] = cmp.mapping.complete({ config = { sources = { { name = "nvim_lsp" } } } }),
        ["<C-x><C-p>"] = cmp.mapping.complete({ config = { sources = { { name = "copilot" } } } }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            if type(fallback) == "function" then
              fallback()
            end
          end
        end, { "i", "s", "c" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            if type(fallback) == "function" then
              fallback()
            end
          end
        end, { "i", "s", "c" }),
      })
    end,
  },
}
