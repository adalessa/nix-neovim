{ pkgs, ... }:
{
  extraPackages = [ pkgs.go ];
  plugins = {
    lsp.servers.gopls.enable = true;
    dap.extensions.dap-go.enable = true;
    none-ls.sources.diagnostics.golangci_lint.enable = true;
  };

  files = {
    "ftplugin/go.lua" = {
      opts = {
        makeprg = "go build";
        expandtab = false;
        listchars = "tab:\\ ,trail:-";
      };
    };
  };
}
