return {
  { "catppuccin/nvim", name = "catppuccin" },

  {
    "sainnhe/gruvbox-material",
    config = function()
      local configure_gruvbox = function()
        vim.cmd([[ 
      let g:gruvbox_material_better_performance = 1
      let g:gruvbox_material_background = "soft"
      let g:gruvbox_material_foreground = "material"
      let g:gruvbox_material_enable_bold = 1
      let g:gruvbox_material_enable_italic = 0
      let s:configuration = gruvbox_material#get_configuration()
      let s:palette = gruvbox_material#get_palette(s:configuration.background, s:configuration.foreground, s:configuration.colors_override)
      " highlight! link TSSymbol Blue
      " highlight! link TSKeyword Red
      execute "highlight!" "DiagnosticUnderlineInfo" "gui=underline" "guisp=" . s:palette.blue[0]
      execute "highlight!" "DiagnosticUnderlineWarn" "gui=underline" "guisp=" . s:palette.orange[0]
      execute "highlight!" "DiagnosticUnderlineError" "gui=underline" "guisp=" . s:palette.red[0]
      ]])
      end
      vim.api.nvim_create_augroup("GruvboxMaterialCustom", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          configure_gruvbox()
        end,
        group = "GruvboxMaterialCustom",
      })
    end,
  },
}
