{ pkgs, ... }:
let helper = import ../helper.nix;
in {
  extraPlugins = with pkgs.vimPlugins; [{
    plugin = git-worktree-nvim;
    config = helper.toLua ''
      require("git-worktree").setup({})
      require("telescope").load_extension("git_worktree")
    '';
  }];

  maps.normal = {
    "<leader>gt" = {
      action = "require('telescope').extensions.git_worktree.git_worktrees";
      lua = true;
    };
    "<leader>gn" = {
      action =
        "require('telescope').extensions.git_worktree.create_git_worktree";
      lua = true;
    };
  };
}
