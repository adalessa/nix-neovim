{pkgs, ...}: {
  extraPackages = [pkgs.htmx-lsp];
  plugins.lsp.enabledServers = [
    {
      name = "htmx";
      extraOptions = {filetypes = ["html" "blade"];};
    }
  ];
}
