{inputs}: (final: prev: {
  vimPlugins = prev.vimPlugins // {
    enfocado = prev.vimUtils.buildVimPlugin {
      name = "enfocado";
      src = inputs.plugin-enfocado;
    };
    laravel = prev.vimUtils.buildVimPlugin {
      name = "laravel";
      src = inputs.plugin-laravel;
    };
  };
})
