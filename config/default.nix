{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./database.nix
    ./dressing.nix
    ./easy-align.nix
    ./fugitive.nix
    ./gitsigns.nix
    ./harpoon.nix
    ./lsp
    ./lualine.nix
    ./laravel.nix
    ./luasnip.nix
    ./neorg.nix
    ./null-ls.nix
    ./options.nix
    ./telescope.nix
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
  maps.normal = {
    "<c-j>" = ":cnext<CR>zz";
    "<c-k>" = ":cprev<CR>zz";
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
