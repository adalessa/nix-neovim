{
  imports = [
    ./languages/go
    ./languages/json
    ./languages/lua
    ./languages/nix
    ./languages/php

    ./frameworks/symfony

    ./modules/database
    ./modules/debug
    ./modules/git
    ./modules/tests
    ./modules/ui
    ./modules/terminal
    ./modules/ai

    ./tools/oil.nix
    ./tools/harpoon.nix
    ./tools/make-runner.nix
    ./tools/scratch.nix
    ./tools/todo-comments.nix
    ./tools/undotree.nix
    ./modules/ai/gp.nix
  ];

  plugins.obsidian = {
    enable = true;
    settings.workspaces = [
      {
        name = "Auto1";
        path = "~/vaults/auto1";
      }
    ];
  };
}
