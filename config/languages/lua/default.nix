{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ lazydev-nvim ];

  extraConfigLuaPre = ''
    require('lazydev').setup({})
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

    cmp.settings.sources = [
      {
        name = "lazydev";
        group_index = 0;
      }
    ];
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
