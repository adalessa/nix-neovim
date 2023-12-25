(member_access_expression
  name: (variable_name (name)) @property (#set! "priority" 115))
(member_access_expression
  name: (name) @property (#set! "priority" 115))
(member_call_expression
  name: (name) @function.method (#set! "priority" 115))
(scoped_call_expression
  name: (name) @function (#set! "priority" 115))

[
  (string)
  (string_value)
  (encapsed_string)
  (heredoc)
  (heredoc_body)
  (nowdoc_body)
] @string (#set! "priority" 115)
