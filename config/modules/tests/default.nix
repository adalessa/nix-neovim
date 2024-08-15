{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ neotest ];

  extraFiles = {
    "lua/neotest-behat.lua".source = ./neotest-behat.lua;
  };

  extraConfigLuaPost = ''
    require("neotest").setup({
      adapters = {
        require("neotest-behat"),
      }
    })
  '';

  imports = [ ./keymaps.nix ];
}
