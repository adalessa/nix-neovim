{
  pkgs,
  inputs,
  helpers,
  lib,
  ...
}:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "my-plugin";
      src = inputs.plugin-kulala;
    })
  ];

  extraConfigLua = ''
    require("kulala").setup()
  '';

  filetype.extension.http = "http";

  files."after/ftplugin/http.lua".keymaps =
    lib.mapAttrsToList
      (key: function: {
        inherit key;
        mode = "n";
        options.buffer = true;
        action = helpers.mkRaw "function() ${function} end";
      })
      {
        "<leader>rn" = "require('kulala').run()";
        "<leader>ra" = "require('kulala').run_all()";
        "<leader>rr" = "require('kulala').replay()";
        "<leader>rs" = "require('kulala').scratchpad()";
        "<leader>rj" = "require('kulala').jump_next()";
        "<leader>rk" = "require('kulala').jump_prev()";
        "<leader>rv" = "require('kulala').toggle_view()";
      };
  keymaps = [
    {
      mode = "n";
      key = "<leader>rp";
      action = helpers.mkRaw "function() require('kulala').search() end";
    }
  ];
}
