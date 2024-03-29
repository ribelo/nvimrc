return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      require("noice").setup({
        debug = false,
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              find = "inlay_hints",
            },
            opts = { skip = true },
          },
          {
            filter = {
              cond = function()
                return not focused
              end,
            },
            view = "notify_send",
            opts = { stop = false },
          },
          {
            filter = {
              event = "msg_show",
              find = "%d+L, %d+B",
            },
            view = "mini",
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          cmdline_output_to_split = false,
          lsp_doc_border = {
            views = {
              hover = {
                border = {
                  style = "rounded",
                },
                position = { row = 2, col = 2 },
                win_options = {
                  winhighlight = "NormalFloat:Normal,FloatBorder:CmpMenuBorder",
                },
              },
            },
          },
        },
        commands = {
          all = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {},
          },
        },
        format = {
          level = {
            icons = false,
          },
        },
        -- views = {
        --   popup = {
        --     border = {
        --       padding = {1, 1},
        --       style = "rounded",
        --     },
        --     win_options = {
        --       winhighlight = {
        --         Normal = "NormalFloat:Normal,FloatBorder:CmpMenuBorder",
        --         FloatBorder = "NormalFloat:Normal,FloatBorder:CmpMenuBorder"
        --       },
        --     }
        --   }
        -- }
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
    end,
  },
}
