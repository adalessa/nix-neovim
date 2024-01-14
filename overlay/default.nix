{inputs, ...}: let
  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };

  modifications = final: prev: {
    phpactor = prev.php.buildComposerProject (finalAttrs: {
      pname = "phpactor";
      version = "master";
      src = inputs.phpactor;
      vendorHash = "sha256-TLxP+BWjQe3gRXuu9Z/gajYcwe/Mj3nJHkiFCB7yocc=";
    });
    php82Packages =
      prev.php82Packages
      // {
        inherit (inputs.nixpkgs-stable.legacyPackages.${final.system}.php82Packages) phpstan;
      };
  };
in
  inputs.nixpkgs.lib.composeManyExtensions [
    additions
    modifications
  ]
