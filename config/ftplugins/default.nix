{
  extraFiles = {
    "ftplugin/cucumber.lua" = builtins.readFile ./cucumber.lua;
    "ftplugin/dbout.vim" = builtins.readFile ./dbout.vim;
    "ftplugin/go.lua" = builtins.readFile ./go.lua;
    "ftplugin/json.vim" = builtins.readFile ./json.vim;
    "ftplugin/nix.lua" = builtins.readFile ./nix.lua;
  };
}
