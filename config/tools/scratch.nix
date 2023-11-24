{pkgs, ...}: let
  helper = import ../../helper.nix;
  inherit (helper) luaAction;
in {
  extraPlugins = with pkgs.extraVimPlugins; [scratch];

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
