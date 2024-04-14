{
  plugins.ollama = {
    enable = true;
    url = "http://10.27.22.101:11434";
  };

  extraConfigLua = ''
    function ollama_lualine_status()
      local status = require("ollama").status()
      local loading = {".  ", ".. ", "..."}

      if status == "IDLE" then
        return "󰒲  "
      elseif status == "WORKING" then
        return loading[math.random(#loading) % #loading + 1]
      end
    end
  '';

  plugins.lualine.sections.lualine_y = [
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
  ];
}
