return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<c-j>"] = require("telescope.actions").move_selection_next,
            ["<c-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-S-V>"] = function()
              vim.api.nvim_put({ vim.fn.getreg("+") }, "", true, true)
            end,
          },
          n = {
            ["q"] = require("telescope.actions").close,
          },
        },
        pickers = {
          marks = {
            theme = "dropdown",
          },
        },
      },
    },
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
      "chip/telescope-software-licenses.nvim",
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>U", "<cmd>Telescope undo<cr>" } },
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          require("telescope").load_extension("file_browser")
        end,
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require("telescope").load_extension("frecency")
        end,
      },
      {
        "jvgrootveld/telescope-zoxide",
        config = function()
          require("telescope").load_extension("zoxide")
        end,
      },
      {
        "benfowler/telescope-luasnip.nvim",
        config = function()
          require("telescope").load_extension("luasnip")
        end,
      },
      {
        "ahmedkhalf/project.nvim",
        opts = function(_, opts)
          return vim.tbl_extend("force", opts, {
            manual_mode = false,
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            silent_chdir = false,
            ignore_lsp = { "tailwindcss", "lua_ls" },
            patterns = { "deps.edn", "project.clj", ".shadow-cljs", ".git", "package.json", "Cargo.toml" },
          })
        end,
        config = function(_, opts)
          require("telescope").load_extension("projects")
          require("project_nvim").setup(opts)
        end,
      },
    },
    config = true,
    keys = {
      { "<leader>ff", ":Telescope file_browser path=%:p:h<CR>", desc = "File browser" },
      { "<leader>fr", ":Telescope frecency<CR>", desc = "Recent files" },
      { "<leader>fR", ":Telescope find_files cwd=~/<CR>", desc = "Home browser" },
      { "<leader>fz", ":Telescope zoxide list<cr>", desc = "Telescope zoxide" },
      { "<leader>fp", ":Telescope git_files<cr>", desc = "Telescope git files" },
      { "<leader>sk", ":Telescope keymaps<CR>", desc = "Keymaps Browser" },
      { "<leader>'", ":Telescope resume<CR>", desc = "Resume" },
      { "<leader>sp", ":Telescope live_grep<CR>", desc = "Live grep cwd" },
      {
        "<leader>sP",
        function()
          require("telescope.builtin").live_grep({
            cwd = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel")),
          })
        end,
        desc = "Live grep git dir",
      },
      {
        "<leader>pp",
        function()
          require("telescope").extensions.projects.projects({})
        end,
        desc = "Live grep",
      },
      { "<leader>,", ":Telescope buffers<CR>", desc = "Telescope buffers" },
      { "<leader>ss", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Current buffer" },
      { "<leader>sm", ":Telescope marks<CR>", desc = "Marks" },
      { "<leader>sS", ":Telescope grep_string<CR>", desc = "Grep string" },
      { "<leader>si", ":Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>sI", ":Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
      { "<leader>st", ":Telescope lsp_type_definitions<CR>", desc = "Workspace types" },
      { "<leader>gb", ":Telescope git_branches<CR>", desc = "Git Branches" },
      { "<m-x>", ":Telescope commands<CR>", desc = "Commands" },
    },
  },
}
