{pkgs, ...}: {
  extraPlugins = with pkgs.extraVimPlugins; [leetcode];
  extraConfigLua = ''
    require('leetcode').setup()
  '';
}
