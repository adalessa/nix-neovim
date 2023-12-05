local ls = require("luasnip")
-- some shorthands...
local snippet_from_nodes = ls.sn
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local d = ls.dynamic_node

local visibility = function(position, default)
  local possibles = { "private", "protected", "public" }
  local options = {}

  for _, value in pairs(possibles) do
    if value == default then
      table.insert(options, 1, t(value))
    else
      table.insert(options, t(value))
    end
  end

  return c(position, options)
end

local var_name = function(args)
  return snippet_from_nodes(nil, {
    i(1, args[1][1]:gsub("^%u", string.lower):gsub("Interface", "") or ""),
  })
end

return {
  s(
    { trig = "objPro", desc = "Creates property for an ObjectProphecy" },
    fmt(
      [[
    /**
     * @var ObjectProphecy<{}>
     */
    private ObjectProphecy ${};
]],
      {
        i(1, "Type"),
        d(2, var_name, { 1 }),
      }
    )),

  s(
    { trig = "initPro", desc = "Initialize a property with a prophesize" },
    fmt(
      [[$this->{} = $this->prophesize({}::class);]],
      {
        i(1, ""),
        i(2, ""),
      }
    )),

  s(
    { trig = "test", desc = "Creates a test function" },
    fmt(
      [[/**
 * @test
 */
public function it_{}(): void
{{
    {}
}}
]],
      { i(1, ""), i(0, "") }
    )),
  s(
    { trig = "fn", desc = "Creates a function" },
    fmt(
      [[{} function {}({}): {}
{{
  {}
}}]],
      { visibility(1, "public"), i(2), i(3), i(4, "void"), i(0) }
    )),



}, {
  -- AUTOTRIGGER
  s(
    { trig = "_p", desc = "Creates a constructor for promoted properties" },
    fmt(
      [[{} function __construct(
    {}
) {{
}}]],
      {
        visibility(1, "public"),
        i(2),
      }
    )),

  s(
    { trig = "pro", desc = "Creates propmoted property param" },
    fmt([[{} {}{} ${},]], {
      visibility(1, "private"),
      c(2, {
        t "readonly ",
        t "",
      }),
      i(3, "Type"),
      d(4, var_name, { 3 }),
    })),

  s(
    { trig = "strict", desc = "Sets the declare strict" },
    t "declare(strict_types=1);"
  ),

  s(
    { trig = "sfn", desc = "Creates an static function" }, fmt(
      [[{} static function {}({}): {}
{{
  {}
}}]],
      { visibility(1, "public"), i(2), i(3), i(4, "void"), i(0) }
    )),
}
