{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [ ultimate-autopairs ];
  extraConfigLua = ''
    require('ultimate-autopair').setup()
  '';
}
