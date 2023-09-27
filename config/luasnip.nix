{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    luasnip
  ];
}
