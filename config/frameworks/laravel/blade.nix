{pkgs, ...}: {
  plugins.treesitter = {
    languageRegister.blade = "blade";
    grammarPackages = [pkgs.extraVimPlugins.nvim-treesitter-parsers.blade];
  };

  extraFiles = {
    "queries/blade/highlights.scm" =
      builtins.readFile ./highlights.scm;
    "queries/blade/injections.scm" =
      builtins.readFile ./injections.scm;
  };

  filetype.pattern.".*%.blade%.php" = "blade";

  extraConfigLua = ''
    do
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = {"src/parser.c"},
          branch = "main",
        },
        filetype = "blade"
      }
    end
  '';
}
