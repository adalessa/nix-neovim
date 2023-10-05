{
  description = "A nixvim configuration";

  inputs = {
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";

    plugin-enfocado = {
      url = "github:wuelnerdotexe/vim-enfocado";
      flake = false;
    };
    plugin-php-lsp-utils = {
      url = "github:adalessa/php-lsp-utils";
      flake = false;
    };
    plugin-laravel = {
      url = "github:adalessa/laravel.nvim/v2";
      flake = false;
    };
    plugin-scratch = {
      url = "github:adalessa/scratch.nvim";
      flake = false;
    };
    plugin-telescope-graphql = {
      url = "github:adalessa/telescope-graphql";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixvim, flake-utils, ... }@inputs:
    let
      config = import ./config; # import the module directly
      overlays = import ./overlays.nix { inherit inputs; };
    in flake-utils.lib.eachDefaultSystem (system:
      let
        nixvimLib = nixvim.lib.${system};
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlays ];
        };
        nixvim' = nixvim.legacyPackages.${system};
        nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = config;
        };
      in {
        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = nixvimLib.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "A nixvim configuration";
          };
        };

        packages = {
          # Lets you run `nix run .` to start nixvim
          default = nvim;
        };
      });
}
