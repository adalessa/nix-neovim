{pkgs, ...}: {
  languages.php.phpactor.enable = true;
  extraPackages = [pkgs.php82];

  extraFiles = {
    "luasnippets/php/php.lua" = builtins.readFile ./snippets.lua;
  };
}
