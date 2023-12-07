{inputs, ...}: let
  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };

  modifications = final: prev: {
    phpactor = prev.php.buildComposerProject (finalAttrs: {
      pname = "phpactor";
      version = "2023.12.03.0";
      src = inputs.phpactor;
      vendorHash = "sha256-0jvWbQubPXDhsXqEp8q5R0Y7rQX3UiccGDF3HDBeh7o=";
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
