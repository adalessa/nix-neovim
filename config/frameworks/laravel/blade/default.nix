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
  plugins = {
    treesitter = {
      languageRegister.blade = "blade";
      grammarPackages = [bladeGrammar];
    };

    none-ls.sources.formatting.blade_formatter = {
      enable = true;
      package = pkgs.blade-formatter;
    };

    lsp.servers.emmet_ls.filetypes = ["blade"];
  };

  extraFiles = {
    "queries/blade/highlights.scm" =
      builtins.readFile ./highlights.scm;
    "queries/blade/injections.scm" =
      builtins.readFile ./injections.scm;
  };

  filetype.pattern.".*%.blade%.php" = "blade";
}
