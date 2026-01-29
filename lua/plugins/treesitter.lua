return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = true,
    opts = { mode = "cursor", multiline_threshold = 10 },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
    },
    opts = {
      ensure_installed = {
        "bash",
        -- "comment", -- comments are slowing down TS bigtime, so disable for now
        "css",
        "clojure",
        "diff",
        "fish",
        "fennel",
        "gitignore",
        -- "help",
        "html",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "tsx",
        "vim",
        "yaml",
        -- "wgsl",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = { enable = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<tab>",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      -- matchup = {
      --   enable = true,
      -- },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    keys = {
      {
        "<leader>li",
        function()
          if not vim.g.makrdown_injections then
            vim.g.markdown_injections = {}
          end
          local lang = vim.bo.filetype
          if markdown_injections[lang] then
            if not vim.g.markdown_injections[lang] then
              vim.notify("Injecting markdown into " .. lang)
              require("vim.treesitter.query").set_query(lang, "injections", markdown_injections[lang])
              vim.g.markdown_injections["foo"] = true
              vim.cmd([[:w]])
              vim.cmd([[:e]])
            else
              vim.notify("Removing markdown injection from " .. lang)
              require("vim.treesitter.query").set_query(lang, "injections", "")
              vim.g.markdown_injections[lang] = false
              vim.cmd([[:w]])
              vim.cmd([[:e]])
            end
          end
        end,
      },
    },
  },
}
