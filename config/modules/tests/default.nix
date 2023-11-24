{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    hydra-nvim
    vim-test
  ];

  # TODO: want to revisit how to set this maybe a function
  extraConfigLua = ''
    do
      ${builtins.readFile ./test.lua}
    end
  '';
}
