{ inputs }:
(final: prev: {
  vimPlugins = prev.vimPlugins // {
    enfocado = prev.vimUtils.buildVimPlugin {
      name = "enfocado";
      src = inputs.plugin-enfocado;
    };
    php-lsp-utils = prev.vimUtils.buildVimPlugin {
      name = "php-lsp-utils";
      src = inputs.plugin-php-lsp-utils;
    };
    laravel = prev.vimUtils.buildVimPlugin {
      name = "laravel";
      src = inputs.plugin-laravel;
    };
    scratch = prev.vimUtils.buildVimPlugin {
      name = "scratch";
      src = inputs.plugin-scratch;
    };
    telescope-graphql = prev.vimUtils.buildVimPlugin {
      name = "telescope-graphql";
      src = inputs.plugin-telescope-graphql;
    };
    transparent = prev.vimUtils.buildVimPlugin {
      name = "transparent";
      src = inputs.plugin-transparent;
    };
    ultimate-autopairs = prev.vimUtils.buildVimPlugin {
      name = "ultimate-autopairs";
      src = inputs.plugin-ultimate-autopairs;
    };
    harpoon = prev.vimUtils.buildVimPlugin {
      name = "harpoon";
      src = inputs.plugin-harpoon;
    };
    leetcode = prev.vimUtils.buildVimPlugin {
      name = "leetcode";
      src = inputs.plugin-leetcode;
    };
  };
  phpactor = prev.php.buildComposerProject (finalAttrs: {
    pname = "phpactor";
    version = "2023.09.24.0";
    src = inputs.phpactor;
    vendorHash = "sha256-YQbYBj9l9FDFFVQ0PtoIp4b6myAPEr2Iit7ZI40C4zg=";
  });
})
