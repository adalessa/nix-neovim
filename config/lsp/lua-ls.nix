{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [ neodev-nvim neoconf-nvim ];

  extraConfigLuaPre = ''
    require('neoconf').setup()
    require('neodev').setup()
  '';

  plugins.lsp.servers.lua-ls.enable = true;
}
