{helpers, ...}: let
  borders = helpers.toLuaObject [
    ["🭽" "FloatBorder"]
    ["▔" "FloatBorder"]
    ["🭾" "FloatBorder"]
    ["▕" "FloatBorder"]
    ["🭿" "FloatBorder"]
    ["▁" "FloatBorder"]
    ["🭼" "FloatBorder"]
    ["▏" "FloatBorder"]
  ];
in {
  extraConfigLuaPost = ''
    do
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or ${borders}

        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end
    end
  '';
}
