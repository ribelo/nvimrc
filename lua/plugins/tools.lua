return {
  { "tpope/vim-fugitive" },
  {
    -- "epwalsh/obsidian.nvim",
    dir = "/home/ribelo/projects/nvim_plugins/obsidian.nvim/",
    lazy = true,
    event = { "BufReadPre " .. vim.fn.expand("~/vault/**.md") },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      dir = "~/vault", -- no need to call 'vim.fn.expand' here

      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "notes",

      -- Optional, if you keep daily notes in a separate directory.
      daily_notes = {
        folder = "journal",
      },

      -- Optional, completion.
      completion = {
        nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
      },

      -- Optional, customize how names/IDs for new notes are created.
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return os.date("%Y%m%d%H%M%S") .. "-" .. suffix
      end,

      -- Optional, set to true if you don't want Obsidian to manage frontmatter.
      disable_frontmatter = false,

      -- Optional, alternatively you can customize the frontmatter data.
      note_frontmatter_func = function(note)
        -- This is equivalent to the default frontmatter function.
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = true,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,

      -- Optional, by default commands like `:ObsidianSearch` will attempt to use
      -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
      -- first one they find. By setting this option to your preferred
      -- finder you can attempt it first. Note that if the specified finder
      -- is not installed, or if it the command does not support it, the
      -- remaining finders will be attempted in the original order.
      finder = "telescope.nvim",
    },
    keys = {
      {
        "gf",
        function()
          vim.print(require("obsidian").util.cursor_on_markdown_link())
          if require("obsidian").util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<CR>"
          else
            return "gf"
          end
        end,
        mode = { "n" },
        expr = true,
        desc = "Goto file or Obsidian",
      },
      { "<leader>ol", ":ObsidianAsLink<CR>", mode = { "v" }, desc = "Obsidian as node" },
      {
        "<leader>oL",
        function()
          vim.ui.input({ prompt = "Enter link name: " }, function(link_name)
            vim.cmd("ObsidianLinkNew " .. link_name)
          end)
        end,
        mode = { "v" },
        desc = "Obsidian make node",
      },
      { "<leader>on", ":ObsidianNew ", mode = { "n" }, desc = "Obsidian new node" },
      { "<leader>oN", ":ObsidianNew<CR>", mode = { "n" }, desc = "Obsidian unique node" },
      { "<leader>ot", ":ObsidianToday<CR>", mode = { "n" }, desc = "Obsidian today" },
      { "<leader>oT", ":ObsidianTemplate<CR>", mode = { "n" }, desc = "Obsidian template" },
      { "<leader>oy", ":ObsidianYesterday<CR>", mode = { "n" }, desc = "Obsidian yesterday" },
      { "<leader>ob", ":ObsidianBacklinks<CR>", mode = { "n" }, desc = "Obsidian backlinks" },
      { "<leader>oo", ":ObsidianOpen<CR>", mode = { "n" }, desc = "Obsidian open" },
      { "<leader>os", ":ObsidianQuickSwitch<CR>", mode = { "n" }, desc = "Obsidian quick switch" },
      { "<leader>so", ":ObsidianSearch<CR>", mode = { "n" }, desc = "Obsidian search" },
    },
  },
  { "pwntester/octo.nvim", opts = {}, cmd = "Octo" },
  { "rktjmp/paperplanes.nvim", opts = {
    provider_options = {
      expires = 24,
    },
  } },
  {
    "NeogitOrg/neogit",
    opts = {
      disable_commit_confirmation = true,
      auto_show_console = false,
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
    config = true,
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
      },
    },
  },
  { "kevinhwang91/rnvimr", keys = { { "<leader>R", ":RnvimrToggle<CR>" } } },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*", "!lazy" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },
}
