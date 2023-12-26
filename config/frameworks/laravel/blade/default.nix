{pkgs, ...}: {
  plugins.treesitter = {
    languageRegister.blade = "blade";
    grammarPackages = [
      pkgs.extraVimPlugins.nvim-treesitter-parsers.blade
      pkgs.extraVimPlugins.nvim-treesitter-parsers.php-only
    ];
  };

  plugins.lsp.servers.emmet_ls.filetypes = ["blade"];

  extraFiles = {
    "queries/blade/highlights.scm" =
      builtins.readFile ./highlights.scm;
    "queries/blade/injections.scm" =
      builtins.readFile ./injections.scm;
    "queries/php_only/highlights.scm" =
      builtins.readFile ./php-only-highlights.scm;
  };

  filetype.pattern.".*%.blade%.php" = "blade";
}
