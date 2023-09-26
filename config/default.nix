{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./colorscheme.nix
    ./options.nix
    ./neorg.nix
    ./harpoon.nix
    ./cmp.nix
    ./lsp
    ./worktree.nix
    ./telescope.nix
    ./comment.nix
    ./lualine.nix
    ./database.nix
  ];

  globals.mapleader = " ";
  clipboard.register = "unnamedplus";

  plugins.fugitive.enable = true;
  plugins.surround.enable = true;
  plugins.nvim-autopairs.enable = true;
  plugins.todo-comments.enable = true;
  plugins.notify = {
    enable = true;
    backgroundColour = "#000000";
  };
  plugins.nix.enable = true;

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
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
