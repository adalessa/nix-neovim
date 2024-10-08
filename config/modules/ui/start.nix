{ helpers, ... }:
let
  header = ''
        _    _       _
       / \  | |_ __ | |__   __ _
      / _ \ | | '_ \| '_ \ / _` |
     / ___ \| | |_) | | | | (_| |
    /_/   \_\_| .__/|_| |_|\__,_|
              |_|
  '';
  footer = ''
     ____                 _
    |  _ \  _____   _____| | ___  _ __   ___ _ __
    | | | |/ _ \ \ / / _ \ |/ _ \| '_ \ / _ \ '__|
    | |_| |  __/\ V /  __/ | (_) | |_) |  __/ |
    |____/ \___| \_/ \___|_|\___/| .__/ \___|_|
                                 |_|
  '';
in
{
  plugins.mini = {
    enable = true;
    modules = {
      starter = {
        inherit header footer;
        items = [
          {
            name = "Git Browser";
            action = helpers.mkRaw ''
              function()
                local opts = { show_untracked = true }
                local ok = pcall(require("telescope.builtin").git_files, opts)
                if not ok then
                  require("telescope.builtin").find_files(opts)
                end
              end
            '';
            section = "Telescope";
          }
          {
            name = "File Browser";
            action = ":Telescope find_files";
            section = "Telescope";
          }
          {
            name = "Worktree";
            action = ":Telescope git_worktree";
            section = "Telescope";
          }
          {
            name = "Branches";
            action = ":Telescope git_branches";
            section = "Telescope";
          }
          {
            name = "Oil";
            action = ":Oil";
            section = "Files";
          }

          {
            name = "Quit";
            action = ":quit";
            section = "Neovim";
          }
          {
            name = "Version";
            action = helpers.mkRaw ''
              function()
                local version = vim.version()
                vim.notify(string.format("Neovim version %d.%d.%d", version.major, version.minor, version.patch))
              end
            '';
            section = "Neovim";
          }
          {
            name = "Health";
            action = helpers.mkRaw ''
              function()
                local checks = vim.health._complete()
                vim.ui.select(checks, { prompt = "HealthCheck" }, function(check)
                  if not check then
                    return
                  end
                  vim.cmd("checkhealth " .. check)
                end)
              end
            '';
            section = "Neovim";
          }
        ];
      };
    };
  };
}
