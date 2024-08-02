{ inputs, ... }:
let
  additions =
    final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };

  modifications = final: prev: {
    phpactor = prev.php.buildComposerProject (finalAttrs: {
      pname = "phpactor";
      version = "master";
      src = inputs.phpactor;
      vendorHash = "sha256-onUhRO6d2osf7n5QlYY86eamlCCslQMVltAv1shskgI=";
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
    php-debug-adapter = prev.stdenv.mkDerivation {
      name = "php-debug-adapter";
      version = "1.33.1";

      src = prev.fetchurl {
        url = "https://github.com/xdebug/vscode-php-debug/releases/download/v1.33.1/php-debug-1.33.1.vsix";
        sha256 = "sha256-oN9xhG8BkK/jLS9aRV4Ff+EHsLcWe60Z2GDlvgkh5HM=";
      };

      buildInputs = [ prev.unzip ];

      phases = [
        "unpackPhase"
        "installPhase"
      ];

      unpackPhase = ''
        mkdir -p $out/extracted
        unzip $src -d $out/extracted
      '';

      installPhase = ''
        mkdir -p $out/bin
        echo '#!/bin/sh' > $out/bin/php-debug-adapter
        echo 'export LD_LIBRARY_PATH=$out/extracted' >> $out/bin/php-debug-adapter
        echo 'exec ${prev.nodejs}/bin/node ${placeholder "out"}/extracted/extension/out/phpDebug.js "$@"' >> $out/bin/php-debug-adapter
        chmod +x "$out/bin/php-debug-adapter"
      '';
    };
  };
in
inputs.nixpkgs.lib.composeManyExtensions [
  additions
  modifications
]
