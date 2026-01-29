return {
  "tpope/vim-fugitive",
  {
    "kkharji/sqlite.lua",
    enabled = function()
      return not jit.os:find("Windows")
    end,
    config = function()
      local path = vim.fn.systemlist("echo $SQLITE_PATH")[1]
      -- local path = "/nix/store/fmh3s032bcsbfcdp82zsjlmkj1kp72j6-sqlite-3.43.1/lib/libsqlite3.so"
      vim.cmd(string.format(
        [[
        let g:sqlite_clib_path = '%s'
        ]],
        path
      ))
    end,
  },
  {
    "Olical/conjure",
    config = function()
      vim.cmd([[
      let g:conjure#extract#tree_sitter#enabled = 1
      let g:conjure#eval#inline#highlight = "Special"
      let g:conjure#highlight#enabled = 1
      let g:conjure#highlight#timeout = 250
      let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = 0
      let g:conjure#client#clojure#nrepl#connection#auto_repl#cmd = ""
      let g:conjure#mapping#def_str = v:false
      let g:conjure#mapping#def_word = v:false
      let g:conjure#mapping#doc_word = v:false
      let g:conjure#mapping#doc_word = v:false
      let g:conjure#mapping#def_word = v:false
      ]])
      vim.keymap.set("x", "<localleader>E", ":WhichKey ,<cr>", {})
    end,
  },
}
