{pkgs, ...}: {
  imports = [./core.nix];

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
    nix.enable = true;

    emmet = {
      enable = true;
      leader = "<c-g>";
      mode = "i";
    };

    rust-tools.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
