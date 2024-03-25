{
  pkgs,
  helpers,
  ...
}: {
  extraPackages = [pkgs.go];
  plugins.lsp.servers.gopls.enable = true;
  plugins.none-ls.sources.diagnostics.golangci_lint.enable = true;

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["go"];
      callback = helpers.mkRaw ''
        function()
          vim.bo.makeprg = "go build"

          vim.opt.listchars:append({tab="> "})

          vim.bo.expandtab = false
          vim.bo.tabstop = 4
          vim.bo.softtabstop = 4
          vim.bo.shiftwidth = 4
        end
      '';
    }
  ];
}
