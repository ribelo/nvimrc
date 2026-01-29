--- disable: no-unknown

-- Fix for bug https://github.com/neovim/neovim/issues/12970
-- vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
--   local text_document = text_document_edit.textDocument
--   local bufnr = vim.uri_to_bufnr(text_document.uri)
--   if offset_encoding == nil then
--     vim.notify_once("apply_text_document_edit must be called with valid offset encoding", vim.log.levels.WARN)
--   end
--
--   vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
-- end
--
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      ---@type table
      local ensure_not_instaled = {
        "stylua",
        "lua-language-server",
        "rust-analyzer",
        "marksman",
        "taplo",
        "nil",
        "pyright",
        "ruff-lsp",
        "ruff",
        "sqlfluff",
      }
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
      keys[#keys + 1] = {
        "<leader>lR",
        function()
          vim.diagnostic.config({
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
                [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
              },
            },
          })
        end,
        desc = "LSP Toggle Diagnostics",
      }
      vim.lsp.set_log_level(vim.lsp.log_levels.OFF)
    end,
    opts = {
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
        -- jdtls = { mason = false, cmd = { "jdt-language-server" } },
        marksman = { mason = false, cmd = { "marksman", "server" } },
        ["ruff"] = { mason = false, cmd = { "ruff", "check" } },
        ["ruff_lsp"] = { mason = false },
        pyright = { mason = false },
        -- rust_analyzer = {
        --   mason = false,
        --   cmd = { "rust-analyzer" },
        --   -- settings = {
        --   --   ["rust-analyzer"] = {
        --   --     procMacro = { enable = true },
        --   --     cargo = { features = "all" },
        --   --     checkOnSave = {
        --   --       command = "clippy",
        --   --       features = "all",
        --   --       extraArgs = { "--no-deps" },
        --   --     },
        --   --   },
        --   -- },
        -- },
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
              hover = { expandAlias = false },
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
                enable = true,
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
          filetypes = { "clojure", "rust" },
          settings = {
            tailwindCSS = {
              includeLanguages = { "rust", "clojure", "javascript" },
              experimental = {
                classRegex = { ':class\\s+"([^"]*)"', 'class: "(.*)"' },
                -- classRegex = {
                --   [[class= "([^"]*)]],
                --   [[class: "([^"]*)]],
                --   [[class= '([^"]*)]],
                --   [[class: '([^"]*)]],
                --   '~H""".*class="([^"]*)".*"""',
                --   '~F""".*class="([^"]*)".*"""',
                -- },
              },
            },
          },
        },
        clojure_lsp = {
          mason = false,
          cmd = { "clojure-lsp" },
        },
        nil_ls = {
          mason = false,
          cmd = { "nil" },
          settings = {
            ["nil"] = {
              formatting = {
                command = { "nixpkgs-fmt" },
              },
            },
          },
        },
      },
      setup = {},
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { "prettierd", "prettier", stop_after_first = true },
        ["markdown.mdx"] = { "prettierd", "prettier", stop_after_first = true },
        ["nix"] = { "nixpkgs-fmt" },
        -- ["javascript"] = { "dprint" },
        -- ["javascriptreact"] = { "dprint" },
        -- ["typescript"] = { "dprint" },
        -- ["typescriptreact"] = { "dprint" },
      },
      formatters = {
        sqlfluff = {
          args = {
            "format",
            "--config",
            vim.fn.getcwd() .. "/.sqlfluff",
            "-",
          },
        },
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
      },
      linters = {
        sqlfluff = {
          args = {
            "lint",
            "--format=json",
            "--config",
            vim.fn.getcwd() .. "/.sqlfluff",
          },
        },
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
