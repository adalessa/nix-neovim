{pkgs, ...}: {
  extraPackages = [pkgs.php-debug-adapter];

  imports = [
    ../../languages/php

    ./telescope-graphql.nix
  ];

  languages.php.phpactor = {
    phpunit.enable = true;
    prophecy.enable = true;
    phpcs = {
      enable = true;
      bin = "%project_root%\/bin\/phpcs";
    };
    phpstan = {
      enable = true;
      bin = "%project_root%\/bin\/phpstan";
      level = "7";
    };
  };

  extraFiles = {
    "luasnippets/php/symfony.lua" = builtins.readFile ./snippets.lua;
  };

  plugins.none-ls = {
    enable = true;
    sources.formatting.phpcbf.enable = true;
  };

  plugins.dap = {
    adapters.executables = {php = {command = "php-debug-adapter";};};
    configurations = {
      php = [
        {
          type = "php";
          request = "launch";
          name = "Symfony";
          port = 9003;
          pathMappings = {"/app" = ''''${workspaceFolder}'';};
        }
      ];
    };
  };

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["cucumber"];
      callback = {
        __raw = ''
          function()
            local set = vim.bo
            set.expandtab = true
            set.tabstop = 2
            set.softtabstop = 2
            set.shiftwidth = 2
            set.smartindent = false
            set.cindent = false
            set.indentexpr = ""
          end
        '';
      };
    }
  ];
}
