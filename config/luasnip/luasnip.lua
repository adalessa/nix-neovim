local ls = require "luasnip"
local types = require "luasnip.util.types"
ls.setup({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into even if you move outside of the selection
  history = true,
  -- This one is cool cause if you have dynamic snippets, it updatesas you type!
  updateevents = "TextChanged,TextChangedI",
  -- Autosnippets:
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<- Choice", "Error" } },
      },
    },
  },
})

local shortcut = function(val)
  if type(val) == "string" then
    return { ls.text_node { val }, ls.insert_node(0) }
  end

  if type(val) == "table" then
    for k, v in ipairs(val) do
      if type(v) == "string" then
        val[k] = ls.text_node { v }
      end
    end
  end

  return val
end

local make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, (ls.s({ trig = k, desc = v.desc }, shortcut(v))))
  end

  return result
end

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/alpha/snippets/*.lua", true)) do
  local ft = vim.fn.fnamemodify(ft_path, ":t:r")
  ls.add_snippets(ft, make(loadfile(ft_path)()))
end

vim.api.nvim_create_user_command('LuaSnipReload', function ()
  -- I want to reload the snippets base on the file
  local snippet_collection = require("luasnip.session.snippet_collection")
  local ft = vim.fn.fnamemodify(vim.fn.expand('%'), ":t:r")
  snippet_collection.clear_snippets(ft)
  ls.add_snippets(ft, make(loadfile(vim.fn.expand('%'))()))
end, {})
