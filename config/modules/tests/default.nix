{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    hydra-nvim
    vim-test
  ];

  globals = {
    "test#strategy" = "neovim";
    "test#neovim#term_position" = "vert";
    "test#php#behat#executable" = "bin/behat";
    "test#php#behat#options" = "--colors";
  };

  # TODO: want to revisit how to set this maybe a function
  extraConfigLua = ''
    do
      ${builtins.readFile ./test.lua}
    end
  '';
}
