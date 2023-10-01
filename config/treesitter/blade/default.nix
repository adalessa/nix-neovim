{
  fetchFromGitHub,
  buildGrammar,
}:
buildGrammar {
  language = "blade";
  version = "0.7.0";
  src = fetchFromGitHub {
    owner = "EmranMR";
    repo = "tree-sitter-blade";
    rev = "a87e20810a71537f42e8eeb11722a19ac6051d1e";
    hash = "sha256-DSDiY6C8zfEE0BTOlbne15cqmPcNdTsl9Cp1huuAqRE=";
  };
}
