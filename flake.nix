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
      url = "github:adalessa/laravel.nvim/feature/container";
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
    plugin-worktree = {
      url = "github:awerebea/git-worktree.nvim/handle_changes_in_telescope_api";
      flake = false;
    };
    blade-treesitter = {
      url = "github:EmranMR/tree-sitter-blade";
      flake = false;
    };
    phpactor = {
      url = "github:phpactor/phpactor";
      flake = false;
    };

    plugin-gp = {
      url = "github:robitx/gp.nvim";
      flake = false;
    };
  };

  outputs = { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { system, pkgs, self', ... }:
        let
          nixvim' = nixvim.legacyPackages.${system};

          core = nixvim'.makeNixvimWithModule {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs;
              ollama = { url = "http://10.27.22.20:11434"; };
            };
            module = ./config/core.nix;
          };

          alpha = core.extend ./config/alpha.nix;
          work = core.extend ./config/work.nix;
        in {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = builtins.attrValues {
              default = import ./overlay { inherit inputs; };
            };
          };

          checks = {
            default = pkgs.nixvimLib.check.mkTestDerivationFromNvim {
              inherit alpha;
              name = "A nixvim configuration";
            };
            pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = { statix.enable = true; };
            };
          };

          formatter = pkgs.nixfmt-rfc-style;

          packages = {
            inherit alpha core work;
            default = alpha;
          };

          devShells = {
            default = pkgs.mkShell {
              inherit (self'.checks.pre-commit-check) shellHook;
            };
          };
        };
    };
}
