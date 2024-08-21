{ pkgs, ... }:
{
  extraPackages = [ pkgs.php-debug-adapter ];
  plugins.dap = {
    adapters.executables.php.command = "php-debug-adapter";
    configurations.php = [
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
}
