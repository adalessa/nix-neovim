{ollama, ...}: {
  extraConfigLua = ''
    ollama_lualine_status_char = 0
    function ollama_lualine_status()
      local status = require("ollama").status()
      -- local loading = {".  ", ".. ", "..."}
      local spinner_chars = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

      if status == "IDLE" then
        ollama_lualine_status_char = 1
        return "󰒲"
      elseif status == "WORKING" then
        ollama_lualine_status_char = ollama_lualine_status_char % #spinner_chars + 1
        return spinner_chars[ollama_lualine_status_char]
      end
    end
  '';
  plugins = {
    ollama = {
      enable = true;
      model = "llama3";
      inherit (ollama) url;
      prompts = {
        laravel_review = {
          system = "Act as a code review tool specialize in PHP focus in Laravel applications.";
          prompt = ''
            Review the following code and respond EXACTLY in the format:\n `<line_number>: <your comment>`.
            NOT add beggining or end comments only add comment if there is an error.
            Code: ```$ftype\n$buf\n```\n
          '';
          action = "display";
        };
        rename_variable = {
          system = "Act as a code review tool.";
          prompt = ''
            In the following $ftype code provide a better name for the variable $sel, respond EXACTLY and ONLY with a list of new names, split by `,`.
            Code: ```$ftype\n$buf\n```\n
          '';
          action = {
            fn = ''
              function (prompt)
                return function (body)
                  local response = body.response:gsub("`", ""):gsub("%s", "")
                  local list = vim.split(response, ",")

                  vim.ui.select(list, {prompt = "Select new Name"}, function (value)
                    if not value then
                      return
                    end
                    vim.lsp.buf.rename(value)
                  end)
                end
              end
            '';
          };
        };
      };
    };

    lualine.sections.lualine_y = [
      {
        name = "ollama_lualine_status()";
        icon = {
          icon = "󰚩 ";
          color = {
            fg = "ffffff";
          };
        };
      }
    ];
  };

  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>oo";
      options.desc = "Ollama Prompt";
      action = ":<c-u>lua require('ollama').prompt()<cr>";
    }
    {
      mode = ["n" "v"];
      key = "<leader>oG";
      options.desc = "Ollama Generate Code";
      action = ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>";
    }
    {
      mode = ["v"];
      key = "<leader>ov";
      options.desc = "Ollama rename variable";
      action = ":<c-u>lua require('ollama').prompt('rename_variable')<cr>";
    }
  ];
}
