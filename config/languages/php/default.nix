{pkgs, ...}: {
  extraPackages = [pkgs.php82 pkgs.php82Packages.composer];

  languages.php.phpactor.enable = true;

  extraFiles = {
    "luasnippets/php/php.lua" = builtins.readFile ./snippets.lua;
  };
}
