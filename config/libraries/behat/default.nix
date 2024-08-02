{ helpers, ... }:
{
  globals = {
    "test#php#behat#executable" = "bin/behat";
    "dispatch_compilers" = {
      "bin/behat" = "behat";
      "behat" = "behat";
      "./vendor/bin/behat" = "behat";
    };

    "test#custom_transformations" = {
      docker = helpers.mkRaw ''
        function(cmd)
          return string.format(
            "-compiler=behat docker compose exec -u %s:%s php-fpm %s",
            vim.uv.getuid(),
            vim.uv.getgid(),
            cmd
          )
        end
      '';
    };
  };

  autoCmd = [
    {
      event = [
        "DirChanged"
        "UIEnter"
      ];
      desc = "Set behat executable";
      callback = helpers.mkRaw ''
        function()
          local behat_paths = {
            "tests/Functional/Context/**/*.php",
            "tests/Behat/Context/*.php",
            "tests/Behat/**/*.php",
            "src/Behat/**/*.php",
          }

          for _, path in ipairs(behat_paths) do
            if vim.fn.glob(path) ~= "" then
              vim.g["test#php#behat#bootstrap_directory"] = path
              vim.g["test#transformation"] = "docker"

              -- many of my projects have variables necessaries so this is required
              local env_vars = vim.fn.system("make vars")
              for _, env_var in ipairs(vim.split(env_vars, "\n")) do
                if env_var ~= "" then
                  env_var = env_var:gsub("^export ", "")
                  local key, value = unpack(vim.split(env_var, "="))
                  vim.uv.os_setenv(key, value)
                end
              end
              break
            end
          end
        end
      '';
    }
  ];

  extraFiles = {
    "compiler/behat.vim".source = ./compiler.vim;
  };
}
