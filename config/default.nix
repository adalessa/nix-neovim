{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [
    ./autocmd.nix
    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./database.nix
    ./dap
    ./diagnostic.nix
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
    ./none-ls.nix
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
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
