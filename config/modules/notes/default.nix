{
  pkgs,
  inputs,
  ...
}: let
  neorg = pkgs.vimUtils.buildVimPlugin {
    name = "neorg";
    src = inputs.plugin-neorg;
  };
in {
  plugins.neorg = {
    enable = true;
    package = neorg;
    modules = {
      "core.defaults" = {__empty = null;};
      "core.concealer" = {__empty = null;};
      "core.dirman" = {
        config = {
          workspaces = {notes = "~/notes";};
          default_workspace = "notes";
        };
      };
    };
  };
}
