{
  pkgs,
  inputs,
  ...
}: let
  twilight = pkgs.vimUtils.buildVimPlugin {
    name = "twilight";
    src = inputs.plugin-twilight;
  };
in {
  extraPlugins = [twilight];
  extraConfigLua = ''
    require('twilight').setup({context = 1})
  '';
}
