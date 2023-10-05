{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./autocmd.nix
    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./database.nix
    ./dressing.nix
    ./easy-align.nix
    ./ftplugins
    ./fugitive.nix
    ./gitsigns.nix
    ./harpoon.nix
    ./keymaps.nix
    ./laravel.nix
    ./lsp
    ./lualine.nix
    ./luasnip
    ./neorg.nix
    ./null-ls.nix
    ./options.nix
    ./scratch.nix
    ./telescope.nix
    ./test.nix
    ./treesitter
    ./worktree.nix
  ];

  globals.mapleader = " ";
  clipboard.register = "unnamedplus";

  plugins.nvim-colorizer.enable = true;
  plugins.surround.enable = true;
  plugins.nvim-autopairs.enable = true;
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
