{
  description = "Alpha's Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-php-lsp-utils = {
      url = "github:adalessa/php-lsp-utils";
      flake = false;
    };
    plugin-laravel = {
      url = "github:adalessa/laravel.nvim/development";
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
    plugin-transparent = {
      url = "github:xiyaowong/nvim-transparent";
      flake = false;
    };
    plugin-ultimate-autopairs = {
      url = "github:altermo/ultimate-autopair.nvim";
      flake = false;
    };
    plugin-twilight = {
      url = "github:folke/twilight.nvim";
      flake = false;
    };
    blade-treesitter = {
      url = "github:EmranMR/tree-sitter-blade";
      flake = false;
    };
    plugin-neorg = {
      url = "github:nvim-neorg/neorg/v7.0.0";
      flake = false;
    };
    phpactor = {
      url = "github:phpactor/phpactor";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {
        system,
        pkgs,
        self',
        ...
      }: let
        nixvim' = nixvim.legacyPackages.${system};
        nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          extraSpecialArgs = {inherit inputs;};
          module = ./config/main.nix;
        };
        work' = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          extraSpecialArgs = {inherit inputs;};
          module = ./config/work.nix;
        };
      in {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues {
            default = import ./overlay {inherit inputs;};
          };
        };

        checks = {
          default = pkgs.nixvimLib.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "A nixvim configuration";
          };
          pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              statix.enable = true;
              alejandra.enable = true;
            };
          };
        };

        formatter = pkgs.alejandra;

        packages = rec {
          default = main;
          main = nvim;
          work = work';
        };

        devShells = {
          default = with pkgs;
            mkShell {inherit (self'.checks.pre-commit-check) shellHook;};
        };
      };
    };
}
