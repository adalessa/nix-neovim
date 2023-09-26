{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./colorscheme.nix
    ./options.nix
    ./neorg.nix
    ./harpoon.nix
    ./cmp.nix
    ./lsp.nix
    ./telescope.nix
    ./comment.nix
    ./lualine.nix
  ];

  globals.mapleader = " ";

  clipboard.register = "unnamedplus";

  plugins.fugitive.enable = true;
  plugins.surround.enable = true;

  plugins.gitsigns = {
    enable = true;
    linehl = false;
    signcolumn = false;
    numhl = true;
  };

  plugins.treesitter = {
    enable = true;
    indent = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-nix
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];

  # extraPackages = with pkgs; [
  # ];
}
