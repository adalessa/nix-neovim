{
  plugins.neorg = {
    enable = true;
    modules = {
      "core.defauls" = { };
      "core.concealer" = { };
      "core.dirman" = {
        config = {
          workspaces = {
            notes = "~/notes";
          };
          default_workspace = "notes";
        };
      };
    };
  };
}
