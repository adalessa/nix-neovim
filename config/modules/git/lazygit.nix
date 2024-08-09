{ pkgs, helpers, ... }:
{
  extraPackages = [ pkgs.lazygit ];

  tools.toggleterm.terminals = [
    {
      cmd = "lazygit";
      dir = "git_dir";
      direction = "float";
      on_open = helpers.mkRaw ''
        function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end
      '';
      on_close = helpers.mkRaw ''
        function(term)
          vim.cmd("startinsert!")
        end
      '';
      keymap = "<leader>gg";
    }
  ];
}
