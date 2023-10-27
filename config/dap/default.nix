{ pkgs, ... }: {
  extraPackages = with pkgs; [ php-debug-adapter ];
  plugins.dap = {
    enable = true;
    adapters.executables = { php = { command = "php-debug-adapter"; }; };
    configurations = {
      php = [
        {
          type = "php";
          request = "launch";
          name = "Laravel";
          port = 9003;
          pathMappings = { "/var/www/html" = "\${workspaceFolder}"; };
        }
        {
          type = "php";
          request = "launch";
          name = "Symfony";
          port = 9003;
          pathMappings = { "/app" = "\${workspaceFolder}"; };
        }
      ];
    };
    signs = {
      dapStopped = {
        text = "→";
        texthl = "DiagnosticWarn";
      };
      dapBreakpoint = {
        text = "B";
        texthl = "DiagnosticInfo";
      };
      dapBreakpointRejected = {
        text = "R";
        texthl = "DiagnosticError";
      };
      dapBreakpointCondition = {
        text = "C";
        texthl = "DiagnosticInfo";
      };
      dapLogPoint = {
        text = "L";
        texthl = "DiagnosticInfo";
      };
    };
    extensions = {
      dap-ui = {
        enable = true;
      };
    };
  };

  extraConfigLuaPost = ''
  local dap_hydra_setup = function ()
      local dap, dapui, hydra = require "dap", require "dapui", require "hydra"
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      local hint = [[
       Nvim DAP
       _d_: Start/Continue  _j_: StepOver _k_: StepOut _l_: StepInto ^
       _bp_: Toogle Breakpoint  _bc_: Conditional Breakpoint ^
       _?_: log point ^
       _c_: Run To Cursor ^
       _h_: Show information of the variable under the cursor ^
       _x_: Stop Debbuging ^
       ^^                                                      _<Esc>_
      ]]

      hydra {
        name = "dap",
        hint = hint,
        mode = "n",
        config = {
          color = "blue",
          invoke_on_body = true,
          hint = {
            border = "rounded",
            position = "bottom",
          },
        },
        body = "<leader>d",
        heads = {
          { "d", dap.continue },
          { "bp", dap.toggle_breakpoint },
          { "l", dap.step_into },
          { "j", dap.step_over },
          { "k", dap.step_out },
          { "h", dapui.eval },
          { "c", dap.run_to_cursor },
          {
            "bc",
            function()
              vim.ui.input({ prompt = "Condition: " }, function(condition)
                dap.set_breakpoint(condition)
              end)
            end,
          },
          {
            "?",
            function()
              vim.ui.input({ prompt = "Log: " }, function(log)
                dap.set_breakpoint(nil, nil, log)
              end)
            end,
          },
          {
            "x",
            function()
              dap.terminate()
              dapui.close {}
              dap.clear_breakpoints()
            end,
          },

          { "<Esc>", nil, { exit = true } },
        },
      }
    end
    dap_hydra_setup()
  '';
}
