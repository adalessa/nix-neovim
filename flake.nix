{
  description = "A nixvim configuration";

  inputs = {
    nixvim.url = "github:adalessa/nixvim";
    flake-utils.url = "github:numtide/flake-utils";

    plugin-enfocado = {
      url = "github:wuelnerdotexe/vim-enfocado";
      flake = false;
    };
  };

  outputs =
    { nixpkgs
    , nixvim
    , flake-utils
    , ...
    } @ inputs:
    let
      config = import ./config; # import the module directly
    in
    flake-utils.lib.eachDefaultSystem (system:
    let
      nixvimLib = nixvim.lib.${system};
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            vimPlugins = prev.vimPlugins // {
              enfocado = prev.vimUtils.buildVimPlugin {
                name = "enfocado";
                src = inputs.plugin-enfocado;
              };
            };
          })
        ];
      };
      nixvim' = nixvim.legacyPackages.${system};
      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = config;
      };
    in
    {
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
