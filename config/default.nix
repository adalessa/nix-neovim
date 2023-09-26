{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./database.nix
    ./easy-align.nix
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
    leader = "<c-,>";
    mode = "i";
  };

  maps.terminal."<esc><esc>" = "<C-\\><C-n>";

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
