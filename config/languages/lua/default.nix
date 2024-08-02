{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    neodev-nvim
    neoconf-nvim
  ];

  extraConfigLuaPre = ''
    require('neoconf').setup()
    require('neodev').setup()
  '';

  extraFiles = {
    "luasnippets/lua/lua.lua".source = ./snippets.lua;
  };

  plugins = {
    lsp.servers.lua-ls.enable = true;
    none-ls.sources = {
      formatting.stylua.enable = true;
      diagnostics.selene.enable = true;
    };
  };

  files = {
    "ftplugin/lua.lua" = {
      opts = {
        tabstop = 2;
        softtabstop = 2;
        expandtab = true;
        shiftwidth = 2;
      };
    };
  };
}
