local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local s = ls.snippet

return {
  s("keymaps", fmt("keymaps = [{}];", { i(1, "") })),
  s("keymap", fmt(
    [[{{
    mode = "{}";
    key = "{}";
    options.desc = "{}";
    action = helpers.mkRaw ''
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
  )),
}
