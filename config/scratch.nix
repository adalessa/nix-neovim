{pkgs, ...}:
let
  helper = import ../helper.nix;
  luaAction = helper.luaAction;
in {

  extraPlugins = with pkgs.vimPlugins; [ scratch ];

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
