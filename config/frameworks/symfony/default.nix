{ pkgs, ... }:
{
  extraPackages = [ pkgs.php-debug-adapter ];

  imports = [
    ../../languages/php

    ./telescope-graphql.nix
  ];

  languages.php.phpactor = {
    phpunit.enable = true;
    prophecy.enable = true;
    phpcs = {
      enable = true;
      bin = "${pkgs.phpPackages.php-codesniffer}/bin/phpcs";
    };
    phpstan = {
      enable = true;
      bin = "${pkgs.phpPackages.phpstan}/bin/phpstan";
      level = "7";
    };
  };

  extraConfigLua = ''
    vim.opt.path:append("tests/**/httpstubs/**/")
  '';

  extraFiles = {
    "luasnippets/php/symfony.lua".source = ./snippets.lua;
  };

  plugins.none-ls = {
    enable = true;
    sources.formatting.phpcbf.enable = true;
    sources.diagnostics.yamllint.enable = true;
  };

  plugins.dap = {
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
          name = "Symfony";
          port = 9003;
          pathMappings = {
            "/app" = "\${workspaceFolder}";
          };
        }
      ];
    };
  };

  files = {
    "ftplugin/cucumber.lua" = {
      opts = {
        tabstop = 2;
        softtabstop = 2;
        expandtab = true;
        shiftwidth = 2;
        smartindent = false;
        cindent = false;
        indentexpr = "";
      };
    };
  };
}
