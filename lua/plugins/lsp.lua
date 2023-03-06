---@diagnostic disable: no-unknown
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>ld",
        function()
          vim.diagnostic.open_float()
        end,
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
        function()
          vim.lsp.buf.code_action()
        end,
        desc = "LSP Code Action",
      }
      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      local diagnostics = require("lazyvim.config").icons.diagnostics
      for type, _ in pairs(diagnostics) do
        diagnostics[type] = signs[type]
      end
    end,
    opts = {
      servers = {
        cssls = {},
        dockerls = {},
        tsserver = {},
        html = {},
        marksman = { mason = false, cmd = { "marksman", "server" } },
        pyright = {},
        rust_analyzer = {
          mason = false,
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
        taplo = {},
        yamlls = {},
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
    },
  },

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local nls = require("null-ls")
      nls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.gitlint,
          nls.builtins.diagnostics.markdownlint,
          -- nls.builtins.diagnostics.luacheck,
          -- nls.builtins.formatting.prettierd.with({
          --   filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
          -- }),
          nls.builtins.diagnostics.selene.with({
            condition = function(utils)
              return utils.root_has_file({ "selene.toml" })
            end,
          }),
          nls.builtins.code_actions.gitsigns,
        },
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
      })
    end,
  },
}
