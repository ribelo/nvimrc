--- disable: no-unknown
return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      ---@type table
      local ensure_not_instaled = { "stylua" }
      ---@param x string
      opts.ensure_installed = vim.tbl_filter(function(x)
        return not vim.list_contains(ensure_not_instaled, x)
      end, opts.ensure_installed)
      vim.list_extend(opts.ensure_installed, {
        "shellcheck",
        "shfmt",
      })
    end,
  },
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
      -- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>ld",
        vim.diagnostic.open_float,
        desc = "LSP Diagnostic Float",
      }
      keys[#keys + 1] = {
        "<leader>lr",
        vim.lsp.buf.rename,
        desc = "LSP Rename",
      }
      keys[#keys + 1] = {
        "<leader>lf",
        require("lazyvim.util").format.format,
        mode = { "n" },
        desc = "LSP Format",
      }
      keys[#keys + 1] = {
        "<leader>lf",
        require("lazyvim.util").format.format,
        mode = { "v" },
        desc = "LSP Format Range",
      }
      keys[#keys + 1] = {
        "<leader>la",
        vim.lsp.buf.code_action,
        desc = "LSP Code Action",
      }
      keys[#keys + 1] = {
        "<leader>lt",
        function()
          if vim.g.lsp_diagnostics_enabled or vim.g.lsp_diagnostics_enabled == nil then
            vim.diagnostic.disable(vim.api.nvim_get_current_buf())
            vim.g.lsp_diagnostics_enabled = false
          else
            vim.diagnostic.enable(vim.api.nvim_get_current_buf())
            vim.g.lsp_diagnostics_enabled = true
          end
        end,
        desc = "LSP Toggle Diagnostics",
      }
      -- vim.lsp.set_log_level(vim.lsp.log_levels.OFF)
    end,
    opts = {
      diagnostics = {
        virtual_text = { prefix = "icons" },
        float = {
          -- focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },
      servers = {
        cssls = {},
        dockerls = {},
        tsserver = {
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        marksman = { mason = false, cmd = { "marksman", "server" } },
        pyright = {},
        rust_analyzer = {
          mason = false,
          cmd = { "rust-analyzer" },
          -- settings = {
          --   ["rust-analyzer"] = {
          --     procMacro = { enable = true },
          --     cargo = { allFeatures = true },
          --     checkOnSave = {
          --       command = "clippy",
          --       extraArgs = { "--no-deps" },
          --     },
          --   },
          -- },
        },
        taplo = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          mason = false,
          cmd = { "lua-language-server" },
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        tailwindcss = {
          filetypes = { "clojure" },
          settings = {
            tailwindCSS = {
              includeLanguages = { "clojure", "javascript" },
              experimental = {
                classRegex = { ':class\\s+"([^"]*)"' },
              },
            },
          },
        },
        clojure_lsp = {
          mason = false,
          cmd = { "clojure-lsp" },
        },
      },
      setup = {},
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
    },
    -- config = function()
    --   local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    --   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --     border = border,
    --   })
    --
    --   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    --     border = border,
    --   })
    -- end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["nix"] = { "nixpkgs-fmt" },
        -- ["javascript"] = { "dprint" },
        -- ["javascriptreact"] = { "dprint" },
        -- ["typescript"] = { "dprint" },
        -- ["typescriptreact"] = { "dprint" },
      },
      formatters = {
        dprint = {
          condition = function(ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
        markdown = { "markdownlint" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
