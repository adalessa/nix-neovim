{pkgs, ...}: let
  helper = import ../../helper.nix;
  inherit (helper) luaAction;
in {
  plugins.harpoon = {
    enable = true;
    package = pkgs.extraVimPlugins.harpoon;
    keymaps = {
      addFile = "<leader>sa";
      toggleQuickMenu = "<leader>ss";
      gotoTerminal = {
        "1" = "<leader><leader>1";
        "2" = "<leader><leader>2";
        "3" = "<leader><leader>3";
      };
      navFile = {
        "1" = "<leader>1";
        "2" = "<leader>2";
        "3" = "<leader>3";
        "4" = "<leader>4";
        "5" = "<leader>5";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>st";
      lua = true;
      action = luaAction ''
        vim.api.nvim_command [[vsplit]]
        require("harpoon.term").gotoTerminal(1)
        vim.api.nvim_command [[startinsert]]
      '';
    }
  ];
}
