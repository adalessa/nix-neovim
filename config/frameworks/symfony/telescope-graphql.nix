{
  pkgs,
  inputs,
  helpers,
  ...
}:
let
  telescope-graphql = pkgs.vimUtils.buildVimPlugin {
    name = "telescope-graphql";
    src = inputs.plugin-telescope-graphql;
  };

  php-lsp-utils = pkgs.vimUtils.buildVimPlugin {
    name = "php-lsp-utils";
    src = inputs.plugin-php-lsp-utils;
  };
in
{
  extraPlugins = [
    telescope-graphql
    php-lsp-utils
  ];

  extraFiles = {
    "lua/graphql_picker.lua".source = ./graphql-picker.lua;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>pm";
      options.desc = "Search Mutation and query";
      action = helpers.mkRaw "function() require('graphql_picker')() end";
    }
  ];
}
