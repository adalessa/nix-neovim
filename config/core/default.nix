{pkgs, ...}: {
  imports = [
    #nix-modules
    ../../modules

    #config
    ./core.nix

    ./autocmd.nix
    ./cmp.nix
    ./diagnostic.nix
    ./easy-align.nix
    ./keymaps.nix
    ./lsp.nix
    ./neogen.nix
    ./snippets.nix
    ./telescope
    ./transparent.nix
    ./treesitter.nix
    ./ultimate-autopairs.nix
  ];

  globals.mapleader = " ";
  clipboard.register = "unnamedplus";
  editorconfig.enable = false;
  plugins = {
    surround.enable = true;
    nvim-lightbulb = {
      enable = true;
      virtualText.enabled = true;
    };

    comment-nvim.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
    direnv-vim
  ];
}
