{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [ leetcode ];
  extraConfigLua = ''
    require('leetcode').setup()
  '';
}
