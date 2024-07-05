{
  plugins.obsidian.settings.picker.name = "telescope.nvim";

  plugins.hydra = {
    enable = true;
    hydras = [
      {
        body = "<leader><leader>o";
        mode = ["n" "v"];
        config = {
          color = "blue";
          invoke_on_body = true;
          hint = {
            float_opts = {
              border = "rounded";
            };
            position = "middle";
          };
        };
        hint = ''
          Obsidian
          _q_: Quick Switch
          _t_: Today
          _x_: Extract to Note
        '';
        heads = [
          ["q" ":ObsidianQuickSwitch<CR>"]
          ["t" ":ObsidianToday<CR>"]
          ["x" ":ObsidianExtract<CR>"]
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
