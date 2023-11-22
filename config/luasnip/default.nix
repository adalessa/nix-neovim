{pkgs, ...}: let
  helper = import ../../helper.nix;
  inherit (helper) luaAction;
in {
  extraPlugins = with pkgs.vimPlugins; [luasnip];

  extraFiles = {
    "lua/alpha/snippets/php.lua" = builtins.readFile ./snippets/php.lua;
    "lua/alpha/snippets/lua.lua" = builtins.readFile ./snippets/lua.lua;
    "lua/alpha/snippets/go.lua" = builtins.readFile ./snippets/go.lua;
    "lua/alpha/snippets/nix.lua" = builtins.readFile ./snippets/nix.lua;
  };

  extraConfigLua = ''
    do
      ${builtins.readFile ./luasnip.lua}
    end
  '';

  keymaps = [
    {
      mode = ["i" "s"];
      key = "<c-k>";
      lua = true;
      action = luaAction ''
        local ls = require('luasnip')
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      '';
      options.silent = true;
    }
    {
      mode = ["i" "s"];
      key = "<c-j>";
      lua = true;
      action = luaAction ''
        local ls = require('luasnip')
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      '';
      options.silent = true;
    }
    {
      mode = ["i" "s"];
      key = "<c-l>";
      lua = true;
      action = luaAction ''
        local ls = require('luasnip')
        if ls.choice_active() then
          ls.change_choice(1)
        end
      '';
      options.silent = true;
    }
  ];
}
