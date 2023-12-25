(member_access_expression
  name: (variable_name (name)) @property (#set! "priority" 130))
(member_access_expression
  name: (name) @property (#set! "priority" 130))
(member_call_expression
  name: (name) @function.method (#set! "priority" 130))

(scoped_call_expression
  scope: (name) @type (#set! "priority" 130)
  name: (name) @function (#set! "priority" 130))

(function_call_expression
  function: [(qualified_name (name)) (name)] @function (#set! "priority" 130))

(variable_name) @variable.builtin (#set! "priority" 130)


[
 "and"
 "as"
 "instanceof"
 "or"
 "xor"
] @keyword.operator (#set! "priority" 130)

[
  "="

  "."
  "-"
  "*"
  "/"
  "+"
  "%"
  "**"

  "~"
  "|"
  "^"
  "&"
  "<<"
  ">>"
  "<<<"

  "->"
  "?->"

  "=>"

  "<"
  "<="
  ">="
  ">"
  "<>"
  "=="
  "!="
  "==="
  "!=="

  "!"
  "&&"
  "||"

  ".="
  "-="
  "+="
  "*="
  "/="
  "%="
  "**="
  "&="
  "|="
  "^="
  "<<="
  ">>="
  "??="
  "--"
  "++"

  "@"
  "::"
] @operator (#set! "priority" 130)

[
 "?>"
 "("
 ")"
 "["
 "]"
 "{"
 "}"
 "#["
 ] @punctuation.bracket (#set! "priority" 130)

[
  (string)
  (string_value)
  (encapsed_string)
  (heredoc)
  (heredoc_body)
  (nowdoc_body)
] @string (#set! "priority" 130)
