return {
  -- Clojure REPL integration
  {
    "Olical/conjure",
    ft = { "clojure" },
    config = function()
      -- Minimal conjure configuration
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
    end,
  },
}