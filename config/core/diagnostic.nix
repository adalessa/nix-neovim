{helpers, ...}: {
  keymaps = [
    {
      mode = "n";
      key = "<leader>vn";
      options.desc = "Go to next diagnostic problem";
      action = helpers.mkRaw "vim.diagnostic.goto_next";
    }
    {
      mode = "n";
      key = "<leader>vp";
      options.desc = "Go to previous diagnostic problem";
      action = helpers.mkRaw "vim.diagnostic.goto_prev";
    }
  ];
  extraConfigLua = ''
    do
      local signs = { Error = "❌", Warn = "🤕", Hint = "💡", Info = "😏" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end
  '';
}
