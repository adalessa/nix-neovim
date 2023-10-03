(binding
  attrpath: (attrpath (identifier) @_path)
  expression: [
    (string_expression
      ((string_fragment) @injection.content (#set! injection.language "lua")))
    (indented_string_expression
      ((string_fragment) @injection.content (#set! injection.language "lua")))
  ]
  (#match? @_path "(^|\\.)(extraConfigLua|extraConfigLuaPost|extraConfigLuaPre|onAttach)$"))

(apply_expression
  function:  (variable_expression (identifier) @_name)
  argument: [
     (string_expression
       ((string_fragment) @injection.content (#set! injection.language "lua")))
     (indented_string_expression
       ((string_fragment) @injection.content (#set! injection.language "lua")))
   ]
  (#match? @_name "(^|\\.)(luaAction|onAttach)$"))
