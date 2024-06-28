{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.notes;
in {
  options = {
    modules.notes = {
      enable = mkEnableOption "notes";
      workspaces = mkOption {
        type = lib.types.listOf lib.types.attrs;
      };
    };
  };
  config = mkIf cfg.enable {
    plugins.obsidian = {
      enable = true;
      settings = {
        inherit (cfg) workspaces;
        picker.name = "telescope.nvim";
      };
    };
  };
}
