{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    hydra-nvim
    vim-test
  ];

  extraConfigLua = ''
    do
      ${builtins.readFile ./test.lua}
    end
  '';
}
