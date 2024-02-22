{
  pkgs,
  helpers,
  ...
}: {
  extraPlugins = with pkgs.vimPlugins; [neodev-nvim neoconf-nvim];

  extraConfigLuaPre = ''
    require('neoconf').setup()
    require('neodev').setup()
  '';

  extraFiles = {
    "luasnippets/lua/lua.lua" = builtins.readFile ./snippets.lua;
  };

  plugins.lsp.servers.lua-ls.enable = true;

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["lua"];
      callback = helpers.mkRaw ''
        function()
          local set = vim.bo

          set.tabstop = 2
          set.softtabstop = 2
          set.expandtab = true
          set.shiftwidth = 2
        end
      '';
    }
  ];
}
