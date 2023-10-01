{pkgs, ...}:let
  tree-sitter-blade = pkgs.callPackage ./blade/default.nix {inherit (pkgs.tree-sitter) buildGrammar;};
in{
  plugins.treesitter = {
    enable = true;
    indent = true;

    languageRegister.blade = "blade";

    grammarPackages =
      pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars
      ++ [tree-sitter-blade];
  };

  extraFiles = {
    "queries/blade/highlights.scm" = builtins.readFile "${tree-sitter-blade}/queries/highlights.scm";
    "queries/blade/injections.scm" = builtins.readFile "${tree-sitter-blade}/queries/injections.scm";
  };

  filetype.pattern.".*%.blade%.php" = "blade";

  extraConfigLua = ''
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.blade = {
      filetype = "blade"
    }
  '';
}
