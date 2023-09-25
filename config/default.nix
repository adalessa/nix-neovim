{ pkgs, ... }: {
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./bufferline.nix
    ./neorg.nix
    ./harpoon.nix
    ./cmp.nix
  ];

  globals.mapleader = " ";

  colorschemes.catppuccin.enable = true;
  clipboard.register = "unnamedplus";

  plugins.fugitive.enable = true;
  plugins.surround.enable = true;

  plugins.lsp = {
    enable = true;
    keymaps.diagnostic = {
      "<leader>vn" = "goto_next";
      "<leader>vp" = "goto_prev";
    };
    keymaps.lspBuf = {
      K = "hover";
      gD = "references";
      gd = "definition";
      gi = "implementation";
      gt = "type_definition";
    };

    onAttach = ''
      vim.keymap.set('n', '<leader>vf', function()
        vim.lsp.buf.format({async = true})
      end)
    '';
    servers = {
      rnix-lsp.enable = true;
      lua-ls.enable = true;
    };
  };

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

  plugins.telescope = {
    enable = true;
    extensions = {
      file_browser.enable = true;
      fzf-native.enable = true;
    };
    keymaps = {
      "<leader>pp" = {
        action = "git_files";
        desc = "Telescope Git Files";
      };
      "<leader>fg" = "live_grep";
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-nix
  ];

  extraPackages = with pkgs; [
  ];
}
