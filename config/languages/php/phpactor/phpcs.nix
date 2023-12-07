{pkgs, ...}: {
  plugins.lsp.servers.phpactor = {
    extraOptions = {
      init_options = {
        "php_code_sniffer.enabled" = true;
        "php_code_sniffer.bin" = "phpcs";
      };
    };
  };

  extraPackages = with pkgs; [php82Packages.phpcs];
}
