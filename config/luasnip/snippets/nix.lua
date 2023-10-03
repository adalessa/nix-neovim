local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

local M = {}

M.keymaps = fmt("keymaps = [{}];", { i("") })

M.keymap = fmt(
  [[{{
    mode = "{}";
    key = "{}";
    options.desc = "{}";
    lua = true;
    action = ''
      function()
        {}
      end
    '';
}}]], {
    i(1, "n"),
    i(2, "<leader>"),
    i(3, ""),
    i(4, ""),
  }
)

return M
