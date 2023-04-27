---@diagnostic disable: no-unknown
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
    },
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
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
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
          cmd = { "rust-analyzer" },
          -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
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
      setup = {
        rust_analyzer = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "rust_analyzer" then
              -- stylua: ignore
              vim.keymap.set("n", "<leader>co", ":RustHoverActions", { buffer = buffer, desc = "Hover Actions (Rust)" })
              vim.keymap.set("n", "<leader>cR", "RustCodeActionGroup", { buffer = buffer, desc = "Code Action (Rust)" })
            end
          end)
          local rust_opts = {
            server = vim.tbl_deep_extend("force", {}, opts, opts.server or {}),
            tools = { -- rust-tools options
              -- options same as lsp hover / vim.lsp.util.open_floating_preview()
              hover_actions = {
                -- whether the hover action window gets automatically focused
                auto_focus = true,
              },
            },
          }
          require("rust-tools").setup(rust_opts)
          return true
        end,
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
