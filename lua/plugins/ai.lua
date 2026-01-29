return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local adapters = require("codecompanion.adapters")

      return {
        adapters = {
          openrouter = function()
            return adapters.extend("openai", {
              url = "https://openrouter.ai/api/v1/chat/completions",
              env = {
                api_key = vim.env.OPENROUTER_API_KEY,
              },
              headers = {
                ["HTTP-Referer"] = "https://github.com/ribelo/nvimrc",
                ["X-Title"] = "ribelo-nvim",
              },
              schema = {
                model = {
                  default = "google/gemini-3-flash-preview",
                },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "openrouter" },
          inline = { adapter = "openrouter" },
          agent = { adapter = "openrouter" },
        },
      }
    end,
  },
}
