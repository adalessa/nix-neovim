{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    indent = true;

    languageRegister.blade = "blade";

    grammarPackages =
      pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars
      ++ [pkgs.extraVimPlugins.nvim-treesitter-parsers.blade];
  };

  extraFiles = {
    "queries/blade/highlights.scm" =
      builtins.readFile "${pkgs.extraVimPlugins.nvim-treesitter-parsers.blade}/queries/highlights.scm";
    "queries/blade/injections.scm" =
      builtins.readFile "${pkgs.extraVimPlugins.nvim-treesitter-parsers.blade}/queries/injections.scm";
    "queries/nix/injections.scm" =
      builtins.readFile ./queries/nix/injections.scm;
  };

  filetype.pattern.".*%.blade%.php" = "blade";

  extraConfigLua = ''
    do
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.blade = {
        filetype = "blade"
      }
    end
  '';

  plugins.treesitter-context.enable = true;
}
