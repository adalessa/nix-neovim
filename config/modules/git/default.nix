{
  imports = [
    ./gitsigns.nix
    ./worktree.nix
    ./lazygit.nix
  ];

  plugins.mini = {
    modules.git = {};
    enable = true;
  };
}
