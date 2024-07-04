{
  plugins.dap = {
    enable = true;
    signs = {
      dapStopped = {
        text = "👉";
        texthl = "DiagnosticWarn";
      };
      dapBreakpoint = {
        text = "🛑";
        texthl = "DiagnosticInfo";
      };
      dapBreakpointRejected = {
        text = "🚫";
        texthl = "DiagnosticError";
      };
      dapBreakpointCondition = {
        text = "🔍";
        texthl = "DiagnosticInfo";
      };
      dapLogPoint = {
        text = "📝";
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
    do
      require('dap').listeners.after.event_initialized["dapui_config"] = function()
        require('dapui').open {}
      end
    end
  '';

  plugins.hydra = {
    enable = true;
    hydras = [
      {
        body = "<leader>d";
        mode = "n";
        config = {
          color = "blue";
          invoke_on_body = true;
          hint = {
            float_opts = {
              border = "rounded";
            };
            position = "bottom";
          };
        };
        hint = ''
          Nvim DAP
          _d_: Start/Continue  _j_: StepOver _k_: StepOut _l_: StepInto ^
          _bp_: Toogle Breakpoint  _bc_: Conditional Breakpoint ^
          _?_: log point ^
          _c_: Run To Cursor ^
          _h_: Show information of the variable under the cursor ^
          _x_: Stop Debbuging ^
          ^^                                                      _<Esc>_
        '';
        heads = [
          [
            "d"
            {__raw = "require('dap').continue";}
          ]
          [
            "bp"
            {__raw = "require('dap').toggle_breakpoint";}
          ]
          [
            "l"
            {__raw = "require('dap').step_into";}
          ]
          [
            "j"
            {__raw = "require('dap').step_over";}
          ]
          [
            "k"
            {__raw = "require('dap').step_out";}
          ]
          [
            "h"
            {__raw = "require('dapui').eval";}
          ]
          [
            "c"
            {__raw = "require('dap').run_to_cursor";}
          ]
          [
            "bc"
            {
              __raw = ''
                function()
                  vim.ui.input({ prompt = "Condition: " }, function(condition)
                    if condition == "" then
                      return
                    end
                    require('dap').set_breakpoint(condition)
                  end)
                end,
              '';
            }
          ]
          [
            "?"
            {
              __raw = ''
                function()
                  vim.ui.input({ prompt = "Log: " }, function(log)
                    if log == "" then
                      return
                    end
                    require('dap').set_breakpoint(nil, nil, log)
                  end)
                end,
              '';
            }
          ]
          [
            "x"
            {
              __raw = ''
                function()
                  require('dap').terminate()
                  require('dapui').close {}
                  require('dap').clear_breakpoints()
                end,
              '';
            }
          ]
          [
            "<Esc>"
            null
            {exit = true;}
          ]
        ];
      }
    ];
  };
}
