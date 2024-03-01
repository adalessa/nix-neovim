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
      vendorHash = "sha256-1id1mBZS2sIR8OkOYdHyR1U/1yWzsSAtMOf0m+4r4tg=";
    });
  };
in
  inputs.nixpkgs.lib.composeManyExtensions [
    additions
    modifications
  ]
