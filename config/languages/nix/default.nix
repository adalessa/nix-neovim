{
  plugins = {
    nix.enable = true;

    lsp.servers.nil_ls.enable = true;

    none-ls = {
      enable = true;
      sources = {formatting.alejandra.enable = true;};
    };
  };

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

  extraFiles = {
    "queries/nix/injections.scm" =
      builtins.readFile ./queries/nix/injections.scm;
  };
}
