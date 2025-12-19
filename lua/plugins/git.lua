return {
  -- Neogit - Primary Git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit Status" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
      { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Neogit Log" },
      { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Neogit Push" },
      { "<leader>gP", "<cmd>Neogit pull<cr>", desc = "Neogit Pull" },
    },
    opts = {
      integrations = {
        fzf_lua = true,
      },
    },
  },


  -- Git signs in the sign column
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev Hunk" })

        -- Actions
        map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame Line" })
        map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
      end,
    },
  },
}