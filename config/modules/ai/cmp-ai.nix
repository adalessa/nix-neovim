{
  pkgs,
  inputs,
  ...
}: let
  cmp-ai = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-ai";
    src = inputs.plugin-cmp-ai;
  };
in {
  extraPlugins = [
    cmp-ai
  ];

  plugins.cmp.settings.mapping = {
    "<c-x>" = "cmp.mapping(cmp.mapping.complete({config = {sources = cmp.config.sources({{name = 'cmp_ai'}})}}),{ 'i' })";
  };

  extraConfigLuaPre = ''
    do
      local cmp_ai = require('cmp_ai.config')

      cmp_ai:setup({
        max_lines = 100,
        provider = 'Ollama',
        provider_options = {
          stream = true,
          --TODO remove ip from the base file
          base_url = 'http://10.27.22.20:11434/api/generate',
          model = 'codellama:7b-code',
        },
        notify = true,
        notify_callback = function(msg)
          vim.notify(msg)
        end,
        run_on_every_keystroke = true,
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
      })
    end
  '';
}
