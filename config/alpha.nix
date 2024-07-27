{
  imports = [
    ./languages/gleam
    ./languages/go
    ./languages/html
    ./languages/json
    ./languages/lua
    ./languages/nix
    ./languages/php
    ./languages/python
    ./languages/rust
    ./languages/typescript

    ./frameworks/htmx
    ./frameworks/laravel
    ./frameworks/svelte
    ./frameworks/tailwindcss
    ./frameworks/vue

    ./libraries/pest

    ./modules/database
    ./modules/debug
    ./modules/git
    ./modules/terminal
    ./modules/tests
    ./modules/ui
    ./modules/ai
    ./modules/godot

    ./tools/harpoon.nix
    ./tools/oil.nix
    ./tools/scratch.nix
    ./tools/todo-comments.nix
    ./tools/undotree.nix
  ];

  plugins.lsp.servers.astro.enable = true;

  plugins.obsidian = {
    enable = true;
    settings.workspaces = [
      {
        name = "Alpha";
        path = "~/vaults/alpha";
      }
    ];
  };
}
