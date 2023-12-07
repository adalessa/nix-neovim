{pkgs, ...}: {
  imports = [
    ../../languages/php

    ../../languages/php/phpactor/phpstan.nix

    ./blade.nix
  ];

  plugins.none-ls.enable = true;

  extraPlugins = with pkgs; [
    extraVimPlugins.laravel
    vimPlugins.nui-nvim
    vimPlugins.vim-dotenv
  ];

  extraPackages = [pkgs.fd pkgs.php-debug-adapter];

  plugins.dap = {
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
