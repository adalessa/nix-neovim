{
  plugins.neotest.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>tn";
      options.desc = "Neotest near test";
      lua = true;
      action = ''
        function()
          require("neotest").run.run()
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>tf";
      options.desc = "Neotest near File";
      lua = true;
      action = ''
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>tt";
      options.desc = "Neotest near test";
      lua = true;
      action = ''
        function()
          require("neotest").summary.toggle()
        end
      '';
    }
  ];
}
