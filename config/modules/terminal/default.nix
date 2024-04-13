{
  pkgs,
  inputs,
  ...
}: let
  toggleterm-manager = pkgs.vimUtils.buildVimPlugin {
    name = "toggleterm-manager";
    src = inputs.plugin-toggleterm-manager;
  };
in {
  plugins.toggleterm = {
    enable = true;
    settings = {
      open_mapping = "'<C-\\>'";
      winbar.enabled = false;
      size = 11;
    };
  };
  extraPlugins = [toggleterm-manager];
  extraConfigLua = ''
    require('toggleterm-manager').setup()
  '';
}
