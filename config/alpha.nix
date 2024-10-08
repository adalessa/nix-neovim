{
  imports = [
    ./languages/go
    ./languages/html
    ./languages/json
    ./languages/lua
    ./languages/nix
    ./languages/php
    ./languages/python
    ./languages/rust
    ./languages/typescript

    ./frameworks/htmx.nix
    ./frameworks/laravel
    ./frameworks/svelte.nix
    ./frameworks/tailwindcss.nix
    ./frameworks/vue.nix
    ./frameworks/astro.nix

    ./modules/database
    ./modules/debug
    ./modules/git
    ./modules/terminal
    ./modules/ui
    ./modules/ai
    ./modules/godot

    ./tools/harpoon.nix
    ./tools/oil.nix
    ./tools/scratch.nix
    ./tools/todo-comments.nix
    ./tools/undotree.nix
    ./tools/kulala.nix
  ];

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
