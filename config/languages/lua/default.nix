{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [neodev-nvim neoconf-nvim];

  extraConfigLuaPre = ''
    require('neoconf').setup()
    require('neodev').setup()
  '';

  extraFiles = {
    "luasnippets/lua/lua.lua" = builtins.readFile ./snippets.lua;
  };

  plugins.lsp.servers.lua-ls.enable = true;

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
