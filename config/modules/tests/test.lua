local function dockerComposeTransform(cmd)
  local uid = vim.fn.system("id -u"):gsub("%s*$", "")
  local gid = vim.fn.system("id -g"):gsub("%s*$", "")
  return string.format("docker compose exec -u %s:%s php-fpm %s", uid, gid, cmd)
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

local hydra = require("hydra")

local hint = [[
     Vim Tests
     _n_: Near test   ^
     _f_: Current file   _s_: Test Suit ^
     _l_: Test Last  _g_: Visit
     _w_: Watch last Test  _p_: stop watch
     ^ ^                                          _<Esc>_ ^
    ]]
local auto_cmd_id = nil
local stopAutoCommand = function()
  if auto_cmd_id ~= nil then
    vim.api.nvim_del_autocmd(auto_cmd_id)
    auto_cmd_id = nil
  end
end
local startAutoCommand = function()
  stopAutoCommand()
  auto_cmd_id = vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.php", "*.feature", "*.yaml" },
    command = "TestLast",
  })
end

hydra({
  name = "vimtest",
  hint = hint,
  mode = "n",
  config = {
    color = "teal",
    invoke_on_body = true,
    hint = {
      float_opts = {
        border = "rounded"
      },
      position = "bottom",
    },
  },
  body = "<leader>t",
  heads = {
    { "n",     ":TestNearest<CR>" },
    { "f",     ":TestFile<CR>" },
    { "s",     ":TestSuit<CR>" },
    { "l",     ":TestLast<CR>" },
    { "g",     ":TestVisit<CR>" },
    { "w",     startAutoCommand },
    { "p",     stopAutoCommand },
    { "<Esc>", nil,               { exit = true } },
  },
})
