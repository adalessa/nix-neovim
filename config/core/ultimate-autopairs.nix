{pkgs, ...}: {
  extraPlugins = with pkgs.extraVimPlugins; [ultimate-autopairs];
  extraConfigLua = ''
    require('ultimate-autopair').setup()
  '';
}
