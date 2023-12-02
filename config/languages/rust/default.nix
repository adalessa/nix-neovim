{
  plugins = {
    rust-tools.enable = true;
    lsp.servers.rust-analyzer = {
      enable = true;
      installCargo = true;
      installRustc = false;
    };
  };
}
