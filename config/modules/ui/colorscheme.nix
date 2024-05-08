{
  pkgs,
  inputs,
  ...
}: let
  oldworld = pkgs.vimUtils.buildVimPlugin {
    name = "oldworld";
    src = inputs.colorscheme-oldworld;
  };
in {
  # colorschemes = {
  #   catppuccin.enable = true;
  # };
  extraPlugins = [oldworld];
  extraConfigLuaPost = ''
    vim.cmd.colorscheme "oldworld"
  '';
}
