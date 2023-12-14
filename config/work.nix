{
  imports = [
    ./core

    ./languages/go
    ./languages/json
    ./languages/lua
    ./languages/nix
    ./languages/php

    ./frameworks/symfony

    ./modules/database
    ./modules/debug
    ./modules/git
    ./modules/notes
    ./modules/tests
    ./modules/ui
    ./modules/terminal

    ./tools/oil.nix
    ./tools/harpoon.nix
    ./tools/make-runner.nix
    ./tools/scratch.nix
    ./tools/todo-comments.nix
  ];
}
