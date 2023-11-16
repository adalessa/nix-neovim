{
  pkgs,
  inputs,
}: {
  nixvimLib = inputs.nixvim.lib.${pkgs.system};

  php-debug-adapter = inputs.php-debug-adapter.packages.${pkgs.system}.default;

  htmx-lsp = pkgs.rustPlatform.buildRustPackage {
    name = "htmx-lsp-server";
    version = "0.1.0";
    cargoLock.lockFile = "${inputs.htmx-lsp}/Cargo.lock";
    src = inputs.htmx-lsp;
  };

  extraVimPlugins = {
    enfocado = pkgs.vimUtils.buildVimPlugin {
      name = "enfocado";
      src = inputs.plugin-enfocado;
    };
    php-lsp-utils = pkgs.vimUtils.buildVimPlugin {
      name = "php-lsp-utils";
      src = inputs.plugin-php-lsp-utils;
    };
    laravel = pkgs.vimUtils.buildVimPlugin {
      name = "laravel";
      src = inputs.plugin-laravel;
    };
    scratch = pkgs.vimUtils.buildVimPlugin {
      name = "scratch";
      src = inputs.plugin-scratch;
    };
    telescope-graphql = pkgs.vimUtils.buildVimPlugin {
      name = "telescope-graphql";
      src = inputs.plugin-telescope-graphql;
    };
    transparent = pkgs.vimUtils.buildVimPlugin {
      name = "transparent";
      src = inputs.plugin-transparent;
    };
    ultimate-autopairs = pkgs.vimUtils.buildVimPlugin {
      name = "ultimate-autopairs";
      src = inputs.plugin-ultimate-autopairs;
    };
    leetcode = pkgs.vimUtils.buildVimPlugin {
      name = "leetcode";
      src = inputs.plugin-leetcode;
    };
    nvim-treesitter-parsers =
      pkgs.vimPlugins.nvim-treesitter-parsers
      // {
        blade = pkgs.tree-sitter.buildGrammar {
          language = "blade";
          version = "0.7.0";
          src = inputs.blade-treesitter;
        };
      };
  };
}
