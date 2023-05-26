--- disable: no-unknown
return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
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
        require("lazyvim.plugins.lsp.format").format,
        mode = { "n" },
        desc = "LSP Format",
      }
      keys[#keys + 1] = {
        "<leader>lf",
        require("lazyvim.plugins.lsp.format").format,
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
      vim.lsp.set_log_level(vim.lsp.log_levels.OFF)
    end,
    opts = {
      -- diagnostics = { virtual_text = { prefix = "icons" } },
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
          settings = {
            ["rust-analyzer"] = {
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
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
                  "--log-level=trace",
                },
              },
              diagnostics = {
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

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        -- nls.builtins.diagnostics.markdownlint,
        nls.builtins.diagnostics.selene.with({
          condition = function(utils)
            return utils.root_has_file({ "selene.toml" })
          end,
        }),
        nls.builtins.diagnostics.luacheck.with({
          condition = function(utils)
            return utils.root_has_file({ ".luacheckrc" })
          end,
        }),
      })
    end,
  },
  -- inlay hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf, true)
        end,
      })
    end,
  },
}
