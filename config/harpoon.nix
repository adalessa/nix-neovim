{
  plugins.harpoon = {
    enable = true;
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

  maps.normal = {
    "<leader>st" = {
      lua = true;
      action = ''
        function ()
          vim.api.nvim_command [[vsplit]]
          require("harpoon.term").gotoTerminal(1)
          vim.api.nvim_command [[startinsert]]
        end
      '';
    };
  };
}
