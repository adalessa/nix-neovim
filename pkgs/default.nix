{
  pkgs,
  inputs,
}: {
  nixvimLib = inputs.nixvim.lib.${pkgs.system};

  php-debug-adapter = inputs.php-debug-adapter.packages.${pkgs.system}.default;

  htmx-lsp = pkgs.rustPlatform.buildRustPackage {
    name = "htmx-lsp-server";
    version = "0.1.0";
    cargoLock.lockFile = "${inputs.htmx-lsp}/Cargo.lock";
    src = inputs.htmx-lsp;
  };
}
