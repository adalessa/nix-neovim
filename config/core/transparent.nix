{ pkgs, inputs, ... }:
let
  transparentPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "transparent";
    src = inputs.plugin-transparent;
  };
in
{
  extraPlugins = [ transparentPlugin ];
  extraConfigLua = ''
    require('transparent').setup()
    require('transparent').clear_prefix('Telescope')
    require('transparent').clear_prefix('Laravel')
  '';
}
