let
  helper = import ../helper.nix;
  luaAction = helper.luaAction;
in {
  keymaps = [
    {
        mode = "n";
        key = "<leader>zz";
        options.desc = "Soundboard";
        lua = true;
        action = luaAction ''
          local action_state = require "telescope.actions.state"
          local actions = require "telescope.actions"
          local Job = require("plenary.job")

          local dir = "/mnt/nas/alpha/soundboard/"

          if vim.fn.isdirectory(dir) == 0 then
            return
          end

          require('telescope.builtin').find_files({
            cwd = dir,
            previewer = false,
            attach_mappings = function(_, map)
              map("i", "<cr>", function(prompt_bufnr)
                actions.close(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                local job = Job:new({
                  command = "mpv",
                  args = { dir .. entry[1] },
                })
                job:start()
              end)
              return true
            end,
          })
        '';
    }
  ];
}
