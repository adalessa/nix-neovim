{
  pkgs,
  inputs,
  ...
}: let
  leetcode = pkgs.vimUtils.buildVimPlugin {
    name = "leetcode";
    src = inputs.plugin-leetcode;
  };
in {
  extraPlugins = [leetcode];
  extraConfigLua = ''
    require('leetcode').setup()
  '';
}
