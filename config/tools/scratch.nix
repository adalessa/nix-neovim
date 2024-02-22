{
  pkgs,
  inputs,
  ...
}: let
  helper = import ../../helper.nix;
  inherit (helper) luaAction;
  scratch = pkgs.vimUtils.buildVimPlugin {
    name = "scratch";
    src = inputs.plugin-scratch;
  };
in {
  extraPlugins = [scratch];

  extraConfigLua = ''
    require('scratch').setup()
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>rs";
      options.desc = "Telescope scratch";
      lua = true;
      action = luaAction ''
        require('scratch').open()
      '';
    }
  ];
}
