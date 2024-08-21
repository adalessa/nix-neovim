{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  laravelPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "laravel";
    src = inputs.plugin-laravel;
  };
in
{
  imports = [
    ./blade
    ./test.nix
    ./dap.nix
    ./status.nix
  ];

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

  extraPackages = [ pkgs.fd ];

  extraConfigLua = "require('laravel').setup()";

  plugins = {
    none-ls = {
      enable = true;
      sources = {
        formatting.pint = {
          enable = true;
          package = null;
        };
      };
    };

    cmp.settings.sources = [ { name = "laravel"; } ];
  };

  keymaps =
    lib.mapAttrsToList
      (key: action: {
        inherit key action;
        mode = "n";
      })
      {
        "<leader>ll" = "<cmd>Laravel<cr>";
        "<c-g>" = "<cmd>Laravel view_finder<cr>";
        "<leader>la" = "<cmd>Laravel art<cr>";
        "<leader>lr" = "<cmd>Laravel routes<cr>";
        "<leader>lh" = "<cmd>Laravel art docs<cr>";
        "<leader>lm" = "<cmd>Laravel make<cr>";
        "<leader>ln" = "<cmd>Laravel related<cr>";
      };
}
