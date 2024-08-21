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
    # TODO: remove after https://github.com/NixOS/nixpkgs/pull/335559 is available in nixos-unstable
    vscode-langservers-extracted = prev.vscode-langservers-extracted.overrideAttrs {
      buildPhase =
        let
          extensions =
            if prev.stdenv.isDarwin then
              "../VSCodium.app/Contents/Resources/app/extensions"
            else
              "../resources/app/extensions";
        in
        ''
          npx babel ${extensions}/css-language-features/server/dist/node \
            --out-dir lib/css-language-server/node/
          npx babel ${extensions}/html-language-features/server/dist/node \
            --out-dir lib/html-language-server/node/
          npx babel ${extensions}/json-language-features/server/dist/node \
            --out-dir lib/json-language-server/node/
          cp -r ${prev.vscode-extensions.dbaeumer.vscode-eslint}/share/vscode/extensions/dbaeumer.vscode-eslint/server/out \
            lib/eslint-language-server
        '';
    };
  };
in
inputs.nixpkgs.lib.composeManyExtensions [
  additions
  modifications
]
