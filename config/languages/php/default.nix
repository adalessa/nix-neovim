{
  imports = [./phpactor];

  languages.php.phpactor.enable = true;

  extraFiles = {
    "luasnippets/php/php.lua" = builtins.readFile ./snippets.lua;
  };
}
