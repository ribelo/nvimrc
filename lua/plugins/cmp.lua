return {
  {
    "nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      {
        "zbirenbaum/copilot-cmp",
        opts = { suggestion = { auto_trigger = true, debounce = 150 } },
      },
    },
    opts = function()
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
      return {
        completion = {
          completeopt = "menu,menuone",
          -- completeopt = "menu,menuone,noinsert",
        },
        style = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
        window = {
          completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            scrollbar = "║",
            winhighlight = "NormalFloat:Normal,FloatBorder:CmpMenuBorder",
            autocomplete = {
              require("cmp.types").cmp.TriggerEvent.InsertEnter,
              require("cmp.types").cmp.TriggerEvent.TextChanged,
            },
          },
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "NormalFloat:Normal,FloatBorder:CmpMenuBorder",
            winblend = 100,
            scrollbar = "║",
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
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
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "copilot", priority = 500 },
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
            priority = 250,
          },
          { name = "path", priority = 0 },
        },
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.exact,
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },
}
