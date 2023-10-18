{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    hydra-nvim
    vim-test
  ];

  extraConfigLua = ''
    local test_setup = function()
      ${builtins.readFile ./test.lua}
    end
    test_setup()
  '';
}
