{
  imports = [
    ./gitsigns.nix
    ./neogit.nix
    ./worktree.nix
  ];

  plugins.mini = {
    modules.git = {};
    enable = true;
  };
}
