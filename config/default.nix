{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./database.nix
    ./fugitive.nix
    ./harpoon.nix
    ./lsp
    ./lualine.nix
    ./neorg.nix
    ./options.nix
    ./telescope.nix
    ./worktree.nix
  ];

  globals.mapleader = " ";
  clipboard.register = "unnamedplus";

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

  plugins.emmet = {
    enable = true;
    leader = "<c-y>";
    mode = "i";
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
