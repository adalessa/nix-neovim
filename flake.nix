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

    colorscheme-oldworld = {
      url = "github:dgox16/oldworld.nvim";
      flake = false;
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
    plugin-worktree = {
      url = "github:awerebea/git-worktree.nvim/handle_changes_in_telescope_api";
      flake = false;
    };
    plugin-neorg = {
      url = "github:nvim-neorg/neorg/v7.0.0";
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

        core = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          extraSpecialArgs = {inherit inputs;};
          module = ./config/core.nix;
        };

        alpha = core.nixvimExtend ./config/alpha.nix;
        work = core.nixvimExtend ./config/work.nix;
      in {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues {
            default = import ./overlay {inherit inputs;};
          };
        };

        checks = {
          default = pkgs.nixvimLib.check.mkTestDerivationFromNvim {
            inherit alpha;
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

        packages = {
          inherit alpha core work;
          default = alpha;
        };

        devShells = {
          default = with pkgs;
            mkShell {inherit (self'.checks.pre-commit-check) shellHook;};
        };
      };
    };
}
