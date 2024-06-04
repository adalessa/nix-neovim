{
  pkgs,
  inputs,
  helpers,
  ...
}: let
  scratch = pkgs.vimUtils.buildVimPlugin {
    name = "scratch";
    src = inputs.plugin-scratch;
  };
in {
  extraPlugins = [scratch];

  extraConfigLua = ''
    require('scratch').setup()
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>rs";
      options.desc = "Telescope scratch";
      action = helpers.mkRaw "require('scratch').open";
    }
  ];
}
