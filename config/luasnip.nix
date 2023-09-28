{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [ luasnip ];
  # TODO: add snips configuration
}
