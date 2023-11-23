let
  helper = import ../../helper.nix;
  inherit (helper) luaAction;
in {
  keymaps = [
    {
      mode = "t";
      key = "<esc><esc>";
      action = "<C-\\><C-n>";
    }
    {
      mode = "n";
      key = "<c-j>";
      action = ":cnext<CR>zz";
    }
    {
      mode = "n";
      key = "<c-k>";
      action = ":cprev<CR>zz";
    }
    {
      mode = "n";
      key = "<c-c><c-c>";
      action = ":cclose<cr>";
    }
    {
      mode = "n";
      key = "<c-c><c-o>";
      action = ":copen<cr>";
    }
    {
      mode = "v";
      key = "<leader>p";
      options.desc = "Special paste, paste without replacing copy register";
      lua = true;
      action = luaAction ''
        local val = vim.fn.getreg '+'
        vim.api.nvim_command [[normal! p]]
        vim.fn.setreg('+', val)
      '';
    }
    {
      mode = "n";
      key = "<leader>bd";
      options.desc = "Deletes current buffer";
      action = ":bd!<cr>";
    }
    {
      mode = "v";
      key = "<";
      options.desc = "Indent out and keeps the selection";
      action = "<gv";
    }
    {
      mode = "v";
      key = ">";
      options.desc = "Indent in and keeps the selection";
      action = ">gv";
    }
    {
      mode = "n";
      key = "n";
      options.desc = "Goes to next result on the search and put the cursor in the middle";
      action = "nzzzv";
    }
    {
      mode = "n";
      key = "N";
      options.desc = "Goes to prev result on the search and put the cursor in the middle";
      action = "Nzzzv";
    }
  ];
}
