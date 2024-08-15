{ helpers, ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>tn";
      options.desc = "";
      action = helpers.mkRaw ''
        function()
          require("neotest").run.run()
        end
      '';
    }

    {
      mode = "n";
      key = "<leader>tm";
      options.desc = "";
      action = helpers.mkRaw ''
        function()
          require("neotest").summary.run_marked()
        end
      '';
    }

    {
      mode = "n";
      key = "<leader>tf";
      options.desc = "";
      action = helpers.mkRaw ''
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end
      '';
    }

    {
      mode = "n";
      key = "<leader>ts";
      options.desc = "";
      action = helpers.mkRaw ''
        function()
          require("neotest").summary.toggle()
        end
      '';
    }

    {
      mode = "n";
      key = "<leader>to";
      options.desc = "";
      action = helpers.mkRaw ''
        function()
          require("neotest").output.open({enter = true})
        end
      '';
    }
  ];
}
