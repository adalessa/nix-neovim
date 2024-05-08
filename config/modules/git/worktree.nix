{
  pkgs,
  inputs,
  ...
}: let
  worktree = pkgs.vimUtils.buildVimPlugin {
    name = "worktree";
    src = inputs.plugin-worktree;
  };
in {
  extraPlugins = [worktree];

  extraConfigLua = ''
    require("git-worktree").setup({})
    require("telescope").load_extension("git_worktree")
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>gt";
      action = "require('telescope').extensions.git_worktree.git_worktrees";
      lua = true;
    }
    {
      mode = "n";
      key = "<leader>gn";
      action = "require('telescope').extensions.git_worktree.create_git_worktree";
      lua = true;
    }
  ];
}
