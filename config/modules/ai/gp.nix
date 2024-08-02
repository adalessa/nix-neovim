{ pkgs, inputs, ... }:
let
  gp = pkgs.vimUtils.buildVimPlugin {
    name = "gp";
    src = inputs.plugin-gp;
  };
in
{
  extraPlugins = [ gp ];

  extraPackages = [ (pkgs.sox.override { enableLame = true; }) ];

  extraConfigLua = ''
    require('gp').setup({
      providers = {
        openai = {
          endpoint = "https://delorean-app.prod.apps.auto1.team/proxy-api/openai/v1/chat/completions",
          secret = { "bw", "get", "password", "delorean" },
        },
      },
      whisper = {
        disable = true;
      }
    })
  '';
}
