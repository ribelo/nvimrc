return {
  { "mrjones2014/nvim-ts-rainbow" },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        -- "comment", -- comments are slowing down TS bigtime, so disable for now
        "cpp",
        "css",
        "clojure",
        "diff",
        "fish",
        "fennel",
        "gitignore",
        "go",
        "graphql",
        "help",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "latex",
        "ledger",
        "lua",
        "markdown",
        "markdown_inline",
        "meson",
        "ninja",
        "nix",
        "norg",
        "org",
        "php",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "sql",
        "svelte",
        "teal",
        "toml",
        "tsx",
        "typescript",
        "tsx",
        "vhs",
        "vim",
        "vue",
        "wgsl",
        "yaml",
        -- "wgsl",
      },
      rainbow = {
        enable = false,
        extended_mode = true,
        max_file_lines = 3000,
        colors = { "#5E81AC", "#B48EAD", "#A3BE8C", "#EBCB8B", "#D08770", "#BF616A" },
      },
      highlight = { enable = true, additional_vim_regex_highlighting = { "org" } },
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
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "function.outer",
            ["if"] = "function.inner",
            ["ac"] = "class.outer",
            ["id"] = "class.inner",
            ["iP"] = "parameter.inner",
            ["aP"] = "@parameter.outer",
          },
        },
        swap = { enable = true },
        move = { enable = true },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = true,
      },
      matchup = {
        enable = true,
      },
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
  },
}
