{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [ clear-action ];

  extraConfigLua = ''
    require('clear-action').setup()
  '';
}
