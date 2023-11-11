{pkgs, ...}: {
  extraPlugins = with pkgs.extraVimPlugins; [transparent];
  extraConfigLua = ''
    require('transparent').setup()
  '';
}
