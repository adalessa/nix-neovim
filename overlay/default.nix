{inputs, ...}: let
  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };

  modifications = final: prev: {
    phpactor = prev.php.buildComposerProject (finalAttrs: {
      pname = "phpactor";
      version = "2023.09.24.0";
      src = inputs.phpactor;
      vendorHash = "sha256-YQbYBj9l9FDFFVQ0PtoIp4b6myAPEr2Iit7ZI40C4zg=";
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
