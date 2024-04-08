{
  pkgs,
  helpers,
  ...
}: let
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
in {
  imports = [./dressing.nix ./lualine.nix ./colorscheme.nix ./borders.nix];
  plugins = {
    nvim-colorizer.enable = true;

    notify = {
      enable = true;
      backgroundColour = "#000000";
    };

    mini = {
      enable = true;
      modules = {
        starter = {
          inherit header footer;
          items = [
            {
              name = "Git Browser";
              action = ":Telescope git_files";
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
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>q";
      options.desc = "Dismiss notifications";
      lua = true;
      action = ''
        function()
          require('notify').dismiss()
        end
      '';
    }
  ];

  extraPlugins = with pkgs.vimPlugins; [
    nvim-web-devicons
  ];
}
