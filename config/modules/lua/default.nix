{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [neodev-nvim neoconf-nvim];

  extraConfigLuaPre = ''
    require('neoconf').setup()
    require('neodev').setup()
  '';

  plugins.lsp.servers.lua-ls.enable = true;

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["lua"];
      callback = {
        __raw = ''
          function()
            local set = vim.bo

            set.tabstop = 2
            set.softtabstop = 2
            set.expandtab = true
            set.shiftwidth = 2
          end
        '';
      };
    }
  ];
}
