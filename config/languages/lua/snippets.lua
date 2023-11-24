local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local snippet_from_nodes = ls.sn

local require_var = function(args, _)
  local text = args[1][1] or ""
  local split = vim.split(text, ".", { plain = true })

  local options = {}
  for len = 0, #split - 1 do
    table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
  end

  return snippet_from_nodes(nil, {
    c(1, options),
  })
end

return {
  s("req", fmt([[local {} = require "{}"]], {
    d(2, require_var, { 1 }),
    i(1),
  }))
}
