{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./autocmd.nix
    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./database.nix
    ./dashboard.nix
    ./dressing.nix
    ./easy-align.nix
    ./fugitive.nix
    ./gitsigns.nix
    ./harpoon.nix
    ./lsp
    ./lualine.nix
    ./laravel.nix
    ./luasnip
    ./neorg.nix
    ./null-ls.nix
    ./options.nix
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

  keymaps = [
    {
      mode = "t";
      key = "<esc><esc>";
      action = "<C-\\><C-n>";
    }
    {
      mode = "n";
      key = "<c-j>";
      action = ":cnext<CR>zz";
    }
    {
      mode = "n";
      key = "<c-k>";
      action = ":cprev<CR>zz";
    }
    {
      mode = "n";
      key = "<c-c><c-c>";
      action = ":cclose<cr>";
    }
    {
      mode = "n";
      key = "<c-c><c-o>";
      action = ":copen<cr>";
    }
  ];

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
    nvim-web-devicons
  ];
}
