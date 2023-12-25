{
  stdenv,
  inputs,
  ...
}:
stdenv.mkDerivation {
  pname = "php-only-grammar";

  src = inputs.php-treesitter;
  version = "0.0.1";

  CFLAGS = ["-Isrc" "-O2"];

  stripDebugList = ["parser"];

  # When both scanner.{c,cc} exist, we should not link both since they may be the same but in
  # different languages. Just randomly prefer C++ if that happens.
  buildPhase = ''
    runHook preBuild
    $CC -fPIC -c php_only/src/scanner.c -o scanner.o $CFLAGS
    $CC -fPIC -c php_only/src/parser.c -o parser.o $CFLAGS
    rm -rf parser
    $CXX -shared -o parser *.o
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir $out
    mv parser $out/
    if [[ -d queries ]]; then
      cp -r queries $out
    fi
    runHook postInstall
  '';
}
