return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      local adapters = require("codecompanion.adapters")

      return {
        adapters = {
          http = {
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
        },
        interactions = {
          background = {
            adapter = {
              name = "openrouter",
              model = "google/gemini-3-flash-preview",
            },
            chat = {
              opts = {
                enabled = false,
              },
            },
          },
          chat = {
            adapter = "openrouter",
          },
          inline = {
            adapter = "openrouter",
          },
          cmd = {
            adapter = "openrouter",
          },
        },
        prompt_library = {
          ["Translate to English"] = {
            interaction = "inline",
            description = "Translate selection to English",
            opts = {
              alias = "translate",
              modes = { "v" },
              auto_submit = true,
              placement = "new",
            },
            prompts = {
              {
                role = "system",
                content = "You are a translation engine. Translate the user's text to English. Keep meaning. Don't add commentary.",
              },
              {
                role = "user",
                content = function(context)
                  local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                  return text
                end,
              },
            },
          },
        },
      }
    end,
  },
}
