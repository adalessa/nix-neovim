{pkgs, ...}: {
  imports = [
    ./core.nix
    ./autocmd.nix
    ./keymaps.nix
  ];

  globals.mapleader = " ";
  clipboard.register = "unnamedplus";
  editorconfig.enable = false;
  plugins = {
    nvim-colorizer.enable = true;
    surround.enable = true;
    todo-comments.enable = true;
    nvim-lightbulb = {
      enable = true;
      virtualText.enabled = true;
    };

    notify = {
      enable = true;
      backgroundColour = "#000000";
    };

    emmet = {
      enable = true;
      leader = "<c-g>";
      mode = "i";
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
