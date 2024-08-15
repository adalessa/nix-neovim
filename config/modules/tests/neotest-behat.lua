local lib = require("neotest.lib")
local tree = require("neotest.types.tree")
local types = require("neotest.types")
local nio = require("nio")

---@class neotest.Adapter
---@field name string
local NeotestAdapter = { name = "neotest-behat" }

---Find the project root directory given a current directory to work from.
---Should no root be found, the adapter can still be used in a non-project context if a test file matches.
---@async
---@param dir string @Directory to treat as cwd
---@return string | nil @Absolute root dir of test suite
function NeotestAdapter.root(dir)
  local result = nil
  for _, root_file in ipairs({ "behat.yml.dist", ".gitignore" }) do
    result = lib.files.match_root_pattern(root_file)(dir)
    if result then
      break
    end
  end

  return result
end

---@async
---@param file_path string
---@return boolean
function NeotestAdapter.is_test_file(file_path)
  local dir = vim.uv.cwd()
  return vim.endswith(file_path, ".feature") and (not vim.startswith(file_path, dir .. "/vendor"))
end

---Given a file path, parse all the tests within it.
---@async
---@param path string Absolute file path
---@return neotest.Tree | nil
function NeotestAdapter.discover_positions(path)
  if not NeotestAdapter.is_test_file(path) then
    return nil
  end

  -- TODO: parse with regular expression, get list of elements

  local lines = require("neotest.lib").files.read_lines(path)
  local scenarios = {}
  local feature = vim.trim(lines[1]:gsub("Feature:", ""))
  for number, line in ipairs(lines) do
    local name = vim.trim(line:gsub("Scenario:", ""):gsub("Scenario Outline:", ""))
    if vim.startswith(line, "  Scenario") then
      table.insert(scenarios, {
        id = feature .. "::" .. name,
        type = "test",
        name = name,
        path = path,
        range = { number - 1, 0, number, 0 },
      })
    end
  end

  table.insert(scenarios, 1, {
    id = path,
    type = "file",
    name = feature,
    path = path,
    range = { 0, 0, #lines, 0 },
  })

  return tree.from_list(scenarios, function(pos)
    return pos.id
  end)
end

---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function NeotestAdapter.build_spec(args)
  local data = args.tree:data()
  local cwd = vim.uv.cwd()
  local path = data.path:gsub(cwd:gsub("%-", "%%-") .. "/", "")

  return {
    command = {
      "make",
      "exec-behat",
      "test=" .. (data.type == "test" and string.format("%s:%s", path, data.range[1] + 1) or path),
    },
  }
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function NeotestAdapter.results(spec, result, tree)
  return {
    [tree:data().id] = {
      status = result.code == 0 and types.ResultStatus.passed or types.ResultStatus.failed,
      output = result.output,
    },
  }
end

return NeotestAdapter
