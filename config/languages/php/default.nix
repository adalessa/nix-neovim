{pkgs, ...}: {
  extraPackages = [pkgs.php83 pkgs.php83Packages.composer];

  languages.php.phpactor.enable = true;

  extraFiles = {
    "luasnippets/php/php.lua" = builtins.readFile ./snippets.lua;
  };

  files = {
    "ftplugin/php.lua" = {
      opts = {
        tabstop = 4;
        softtabstop = 4;
        expandtab = true;
        shiftwidth = 4;
      };
    };
  };
}
