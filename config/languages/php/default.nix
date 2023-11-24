{
  imports = [./phpactor.nix];

  extraFiles = {
    "luasnippets/php/php.lua" = builtins.readFile ./snippets.lua;
  };
}
