{ pkgs, inputs, ... }:
let
  ultimate-autopairs = pkgs.vimUtils.buildVimPlugin {
    name = "ultimate-autopairs";
    src = inputs.plugin-ultimate-autopairs;
  };
in
{
  extraPlugins = [ ultimate-autopairs ];
  extraConfigLua = ''
    require('ultimate-autopair').setup({
      cmap = false,
    })
  '';
}
