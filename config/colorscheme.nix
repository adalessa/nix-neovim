{ pkgs, ... }: {
  extraPlugins = [{
    plugin = pkgs.vimPlugins.enfocado;
    # config = "let g:enfocado_style = 'neon'";
  }];
  colorscheme = "enfocado";
}
