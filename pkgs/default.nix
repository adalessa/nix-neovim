{
  pkgs,
  inputs,
}: {
  nixvimLib = inputs.nixvim.lib.${pkgs.system};

  php-debug-adapter = inputs.php-debug-adapter.packages.${pkgs.system}.default;
}
