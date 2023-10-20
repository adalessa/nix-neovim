{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./autocmd.nix
    # ./clear-action.nix
    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./database.nix
    ./dressing.nix
    ./easy-align.nix
    ./ftplugins
    ./gitsigns.nix
    ./harpoon.nix
    ./keymaps.nix
    ./laravel.nix
    ./leetcode.nix
    ./lsp
    ./lualine.nix
    ./luasnip
    ./neogit.nix
    ./neorg.nix
    ./null-ls.nix
    ./options.nix
    ./scratch.nix
    ./soundboard.nix
    ./telescope.nix
    ./test
    ./transparent.nix
    ./treesitter
    ./ultimate-autopairs.nix
    ./worktree.nix
  ];

  globals.mapleader = " ";
  clipboard.register = "unnamedplus";

  plugins.nvim-colorizer.enable = true;
  plugins.surround.enable = true;
  plugins.todo-comments.enable = true;
  plugins.nvim-lightbulb = {
    enable = true;
    virtualText.enabled = true;
  };

  plugins.notify = {
    enable = true;
    backgroundColour = "#000000";
  };
  plugins.nix.enable = true;

  plugins.emmet = {
    enable = true;
    leader = "<c-l>";
    mode = "i";
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
