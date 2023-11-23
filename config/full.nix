{
  imports = [
    ./core

    # Others should be part of the core
    # Core plugins & configs should not be related to an specific language
    # If so should go to the specific module

    # Create another configs Full is of course all, but have something like Symfony or work or similar without what I don't need
    # To start I need 2

    # make a module per language where it makes sense
    # PHP
    # Laravel
    # Symfony
    # Javascript
    # Vue
    # React
    # Golang
    # Rust
    ./modules/nix
    ./modules/rust
    ./modules/laravel
    ./modules/symfony

    ./cmp.nix
    ./colorscheme.nix
    ./comment.nix
    ./database.nix
    ./dap
    ./diagnostic.nix
    ./dressing.nix
    ./easy-align.nix
    ./gitsigns.nix
    ./harpoon.nix
    ./leetcode.nix
    ./lsp
    ./lualine.nix
    ./luasnip
    ./neogit.nix
    ./neorg.nix
    ./none-ls.nix
    ./scratch.nix
    ./soundboard.nix
    ./telescope.nix
    ./test
    ./transparent.nix
    ./treesitter
    ./ultimate-autopairs.nix
    ./worktree.nix
  ];
}
