{pkgs, ...}: {
  extraPlugins = with pkgs.extraVimPlugins; [twilight];
  extraConfigLua = ''
    require('twilight').setup({context = 1})
  '';
}
