{pkgs, ...}: {
  imports = [
    #nix-modules
    ../../modules

    #config
    ./core.nix

    ./autocmd.nix
    ./cmp
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
    ./bqf.nix
  ];

  plugins.obsidian.settings.picker.name = "telescope.nvim";

  globals.mapleader = " ";
  clipboard.register = "unnamedplus";
  editorconfig.enable = false;
  plugins = {
    surround.enable = true;
    nvim-lightbulb = {
      enable = true;
      settings = {
        virtualText.enabled = true;
      };
    };

    direnv.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-eunuch
  ];
}
