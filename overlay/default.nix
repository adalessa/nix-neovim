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
      vendorHash = "sha256-9YN+fy+AvNnF0Astrirpewjmh/bSINAhW9fLvN5HGGI=";
    });
  };
in
  inputs.nixpkgs.lib.composeManyExtensions [
    additions
    modifications
  ]
