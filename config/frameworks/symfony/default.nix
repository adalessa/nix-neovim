{pkgs, ...}: {
  extraPackages = [pkgs.php-debug-adapter];

  imports = [../../languages/php ./telescope-graphql.nix];

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
