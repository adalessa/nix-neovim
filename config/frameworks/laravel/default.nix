{
  pkgs,
  inputs,
  ...
}: let
  laravelPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "laravel";
    src = inputs.plugin-laravel;
  };
in {
  imports = [
    ../../languages/php

    ./blade
  ];

  languages.php.phpactor = {
    phpunit.enable = true;
  };

  extraPlugins = with pkgs; [
    laravelPlugin
    vimPlugins.nui-nvim
    vimPlugins.vim-dotenv
  ];

  extraPackages = [pkgs.fd pkgs.php-debug-adapter];
  plugins = {
    none-ls = {
      enable = true;
      sources = {
        formatting.pint = {
          enable = true;
          package = null;
        };
        diagnostics.phpstan.enable = true;
      };
    };

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
      key = "<leader>ll";
      action = ":Laravel<cr>";
    }
    {
      mode = "n";
      key = "<c-g>";
      lua = true;
      action = "function() require('laravel').viewFinder() end";
    }
    {
      mode = "n";
      key = "<leader>la";
      lua = true;
      action = "function() require('laravel').artisan() end";
    }
    {
      mode = "n";
      key = "<leader>lr";
      lua = true;
      action = "function() require('laravel').routes() end";
    }
    {
      mode = "n";
      key = "<leader>lh";
      action = ":Artisan docs<cr>";
    }
    {
      mode = "n";
      key = "<leader>lm";
      lua = true;
      action = "function() require('laravel').make() end";
    }
    {
      mode = "n";
      key = "<leader>lq";
      lua = true;
      action = "function() require('laravel').history() end";
    }
    {
      mode = "n";
      key = "<leader>lc";
      lua = true;
      action = "function() require('laravel').commands() end";
    }
    {
      mode = "n";
      key = "<leader>lo";
      lua = true;
      action = "function() require('laravel').resources() end";
    }
  ];
}
