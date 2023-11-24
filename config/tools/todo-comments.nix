{
  plugins.todo-comments.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader><leader>td";
      options.desc = "TodoTelescope";
      action = ":TodoTelescope<cr>";
    }
  ];
}
