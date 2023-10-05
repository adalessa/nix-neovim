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
  };
})
