return {
  {
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      vim.opt.completeopt = "menuone,noselect"
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })
      vim.api.nvim_create_autocmd("ModeChanged", {
        group = unlinkgrp,
        pattern = { "s:n", "i:*" },
        desc = "Forget the current snippet when leaving the insert mode",
        callback = function(evt)
          if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
            luasnip.unlink_current()
          end
        end,
      })
      opts.completion = vim.tbl_extend("force", opts.completion, {
        completeopt = "menu,menuone",
        -- completeopt = "menu,menuone,noinsert",
      })
      opts.style = {
        -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      }
      opts.window = {
        completion = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          scrollbar = "║",
          winhighlight = "NormalFloat:Normal,FloatBorder:CmpMenuBorder",
          autocomplete = {
            require("cmp.types").cmp.TriggerEvent.InsertEnter,
            require("cmp.types").cmp.TriggerEvent.TextChanged,
          },
        },
      }
      -- opts.documentation = {
      --   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      --   winhighlight = "NormalFloat:Normal,FloatBorder:CmpMenuBorder",
      --   winblend = 100,
      --   scrollbar = "║",
      -- }
      opts.snippet = vim.tbl_extend("force", opts.snippet, {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      })
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
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

        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
      opts.sources = vim.tbl_extend("force", opts.sources, {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        { name = "path" },
      })
      opts.formatting = vim.tbl_extend("force", opts.formatting, {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      })
      opts.experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      }
    end,
  },
}
