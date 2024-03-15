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
    blade-formatter = prev.mkYarnPackage rec {
      pname = "blade-formatter";
      version = "1.41.1";
      src = prev.fetchFromGitHub {
        owner = "shufo";
        repo = pname;
        rev = "v${version}";
        hash = "sha256-iaWpIa+H+ocAXGc042PfmCu9UcJZeso9ripWB2/1oTs=";
      };

      postBuild = "yarn build";
    };
  };
in
  inputs.nixpkgs.lib.composeManyExtensions [
    additions
    modifications
  ]
