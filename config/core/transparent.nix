{pkgs, ...}: {
  extraPlugins = with pkgs.extraVimPlugins; [transparent];
  extraConfigLua = ''
    require('transparent').setup()
    require('transparent').clear_prefix('Telescope')
  '';
}
