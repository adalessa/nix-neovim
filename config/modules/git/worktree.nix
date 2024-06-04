{
  pkgs,
  inputs,
  helpers,
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
      action = helpers.mkRaw "require('telescope').extensions.git_worktree.git_worktrees";
    }
    {
      mode = "n";
      key = "<leader>gn";
      action = helpers.mkRaw "require('telescope').extensions.git_worktree.create_git_worktree";
    }
  ];
}
