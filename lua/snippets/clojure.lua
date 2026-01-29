local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

ls.add_snippets("clojure", {
  s("m/=>", { t("(m/=>"), i(1), t("[:=> [:cat "), i(2), t("]"), i(3), t("])") }),
})
