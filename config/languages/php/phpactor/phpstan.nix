{pkgs, ...}: {
  plugins.lsp.servers.phpactor = {
    extraOptions = {
      init_options = {
        "language_server_phpstan.enabled" = true;
        "language_server_phpstan.level" = "7";
        "language_server_phpstan.bin" = "phpstan";
      };
    };
  };

  extraPackages = with pkgs; [php82Packages.phpstan];
}
