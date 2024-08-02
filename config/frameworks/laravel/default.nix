{
  pkgs,
  inputs,
  helpers,
  ...
}:
let
  laravelPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "laravel";
    src = inputs.plugin-laravel;
  };
in
{
  imports = [ ./blade ];

  languages.php.phpactor = {
    phpunit.enable = true;
    phpstan = {
      enable = true;
      level = "6";
      bin = "${pkgs.phpPackages.phpstan}/bin/phpstan";
    };
  };

  extraPlugins = [
    laravelPlugin
    pkgs.vimPlugins.nui-nvim
    pkgs.vimPlugins.vim-dotenv
  ];

  extraPackages = [
    pkgs.fd
    pkgs.php-debug-adapter
  ];
  plugins = {
    none-ls = {
      enable = true;
      sources = {
        formatting.pint = {
          enable = true;
          package = null;
        };
        # diagnostics.phpstan.enable = true;
      };
    };

    dap = {
      adapters.executables = {
        php = {
          command = "php-debug-adapter";
        };
      };
      configurations = {
        php = [
          {
            type = "php";
            request = "launch";
            name = "Laravel";
            port = 9003;
          }
          {
            type = "php";
            request = "launch";
            name = "Laravel Sail";
            port = 9003;
            pathMappings = {
              "/var/www/html" = "\${workspaceFolder}";
            };
          }
        ];
      };
    };

    lualine.sections = {
      lualine_x = [
        {
          name = "require('laravel.app')('status'):get('php')";
          icon = {
            icon = " ";
            color = {
              fg = "5e79be";
            };
          };
        }
        {
          name = "require('laravel.app')('status'):get('laravel')";
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
      action = helpers.mkRaw "function() require('laravel').viewFinder() end";
    }
    {
      mode = "n";
      key = "<leader>la";
      action = ":Laravel art<cr>";
    }
    {
      mode = "n";
      key = "<leader>lr";
      action = ":Laravel routes<cr>";
    }
    {
      mode = "n";
      key = "<leader>lh";
      action = ":Laravel art docs<cr>";
    }
    # {
    #   mode = "n";
    #   key = "<leader>lm";
    #   action = helpers.mkRaw "function() require('laravel').make() end";
    # }
    # {
    #   mode = "n";
    #   key = "<leader>lq";
    #   action = helpers.mkRaw "function() require('laravel').history() end";
    # }
    # {
    #   mode = "n";
    #   key = "<leader>lc";
    #   action = helpers.mkRaw "function() require('laravel').commands() end";
    # }
    # {
    #   mode = "n";
    #   key = "<leader>lo";
    #   action = helpers.mkRaw "function() require('laravel').resources() end";
    # }
    {
      mode = "n";
      key = "<leader>rr";
      options.desc = "Load Laravel plugin from local";
      action = helpers.mkRaw ''
        function()
          vim.opt.runtimepath:prepend("~/code/plugins/laravel.nvim")
          local reload = require("plenary.reload")
          reload.reload_module("laravel")
          reload.reload_module("telescope")
          local laravel = require("laravel")
          laravel.setup({})
        end
      '';
    }
  ];
}
