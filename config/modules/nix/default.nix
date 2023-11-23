{
  plugins.nix.enable = true;

  plugins.lsp.servers.nil_ls.enable = true;

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["nix"];
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
