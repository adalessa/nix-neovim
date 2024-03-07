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
      vendorHash = "sha256-cfbDeadjfIrGCz7pZpIDNQLoF7ym8FhQj/kNGWs+haw=";
    });
  };
in
  inputs.nixpkgs.lib.composeManyExtensions [
    additions
    modifications
  ]
