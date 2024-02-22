{
  pkgs,
  inputs,
  ...
}: let
  bladeGrammar = pkgs.tree-sitter.buildGrammar {
    language = "blade";
    version = "0.9.2";
    src = inputs.blade-treesitter;
  };
in {
  plugins.treesitter = {
    languageRegister.blade = "blade";
    grammarPackages = [bladeGrammar];
  };

  plugins.lsp.servers.emmet_ls.filetypes = ["blade"];

  extraConfigLuaPost = ''
    require("null-ls").register(require('null-ls').builtins.formatting.blade_formatter.with {
      command = "./node_modules/blade-formatter/bin/blade-formatter.js"
    })
  '';

  extraFiles = {
    "queries/blade/highlights.scm" =
      builtins.readFile ./highlights.scm;
    "queries/blade/injections.scm" =
      builtins.readFile ./injections.scm;
  };

  filetype.pattern.".*%.blade%.php" = "blade";
}
