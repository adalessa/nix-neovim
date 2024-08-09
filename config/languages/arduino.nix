{ pkgs, ... }:
{
  # language server is not in nixvim
  plugins.lsp.servers = {
    arduino.enable = true;
    clangd.enable = true;
  };

  extraPackages = [ pkgs.arduino-cli ];
}
