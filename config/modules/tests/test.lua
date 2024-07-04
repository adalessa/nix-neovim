do
  local function dockerComposeTransform(cmd)
    local uid = vim.fn.system("id -u"):gsub("%s*$", "")
    local gid = vim.fn.system("id -g"):gsub("%s*$", "")
    return string.format("-compiler=behat docker compose exec -u %s:%s php-fpm %s", uid, gid, cmd)
  end

  vim.g["test#custom_transformations"] = { docker = dockerComposeTransform }

  vim.api.nvim_create_autocmd({ "DirChanged", "UIEnter" }, {
    pattern = { "*" },
    callback = function()
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
              vim.fn.setenv(key, value)
            end
          end
          break
        end
      end
    end,
  })
end
