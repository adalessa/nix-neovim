{
  imports = [
    ./core

    ./languages/go
    ./languages/html
    ./languages/json
    ./languages/lua
    ./languages/nix
    ./languages/php
    ./languages/rust
    ./languages/typescript

    ./frameworks/laravel
    ./frameworks/htmx
    ./frameworks/tailwindcss
    ./frameworks/vue
    ./frameworks/svelte

    ./modules/database
    ./modules/debug
    ./modules/git
    ./modules/notes
    ./modules/tests
    ./modules/ui

    ./tools/harpoon.nix
    ./tools/leetcode.nix
    ./tools/make-runner.nix
    ./tools/scratch.nix
    ./tools/todo-comments.nix
  ];
}