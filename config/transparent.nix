{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [ transparent ];
  extraConfigLua = ''
    require('transparent').setup()
  '';
}
