{
  pkgs,
  helpers,
  ...
}: {
  extraPlugins = [pkgs.vimPlugins.vim-dispatch];

  keymaps = [
    {
      mode = "n";
      key = "<leader>mm";
      options.desc = "Runs make command";
      action = helpers.mkRaw ''
        function()
          local items =
            vim.fn.systemlist "make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\\/\t=]*:([^=]|$)/ {split($1,A,/ /);print A[1]}'"

          if vim.tbl_isempty(items) then
            vim.notify("No make items", vim.log.levels.WARN, {})
          end

          vim.ui.select(vim.fn.uniq(items), { promt = "Make command" }, function(choice)
          if not choice then
            return
          end

          vim.cmd(string.format("Dispatch make %s", choice))
          end)
        end
      '';
    }
  ];
}
