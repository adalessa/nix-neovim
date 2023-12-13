{pkgs, ...}: {
  imports = [
    ../../languages/php

    ./blade.nix
  ];

  extraPlugins = with pkgs; [
    extraVimPlugins.laravel
    vimPlugins.nui-nvim
    vimPlugins.vim-dotenv
  ];

  extraPackages = [pkgs.fd pkgs.php-debug-adapter];
  plugins = {
    none-ls.enable = true;

    dap = {
      adapters.executables = {php = {command = "php-debug-adapter";};};
      configurations = {
        php = [
          {
            type = "php";
            request = "launch";
            name = "Laravel";
            port = 9003;
            pathMappings = {"/var/www/html" = ''''${workspaceFolder}'';};
          }
        ];
      };
    };

    lualine.sections = {
      lualine_x = [
        {
          name = "require('laravel.status').get('php')";
          icon = {
            icon = " ";
            color = {
              fg = "5e79be";
            };
          };
        }
        {
          name = "require('laravel.status').get('laravel')";
          icon = {
            icon = " ";
            color = {
              fg = "f9322c";
            };
          };
        }
      ];
    };
  };

  extraConfigLua = ''
    require('laravel').setup()
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>la";
      action = ":Laravel artisan<cr>";
    }
    {
      mode = "n";
      key = "<leader>lr";
      action = ":Laravel routes<cr>";
    }
    {
      mode = "n";
      key = "<leader>lh";
      action = ":Artisan docs<cr>";
    }
  ];
}
