local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local sources = {
  "_mutation.yaml",
  "_mutation_external_anonymous.yaml",
  "_mutation_public_api.yaml",
  "_query.yaml",
  "_query_external_anonymous.yaml",
  "_query_public_api.yaml",
}

local function get_files()
  local files = {}

  for _, source in ipairs(sources) do
    local path = vim.fn.findfile(source, "config/graphql")
    if path ~= "" then
      table.insert(files, vim.fn.getcwd() .. "/" .. path)
    end
  end

  return files
end

return function()
  local files = get_files()

  if #files == 0 then
    vim.notify("No graphql files found", vim.log.levels.WARN, {})
    return
  end

  require("telescope").extensions.graphql.definitions({
    files = files,
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<c-o>", function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        local args = string.match(selection.resolver, "'@=mutation%((.+)%)'")
        if args == nil then
          args = string.match(selection.resolver, "'@=query%((.+)%)'")
        end
        if args == nil then
          return
        end

        local args_tbl = vim.split(args, ", ")
        local fqn = string.match(args_tbl[1], '"(.+)"')
        fqn = string.gsub(fqn, "\\\\", "\\")

        local search = vim.split(fqn, "::")
        local fqn_class = search[1]
        local method = search[2]

        require("php-lsp-utils").go_to("phpactor", fqn_class, method)
      end)

      map("i", "<c-f>", function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        require("telescope.builtin").grep_string({ search = selection.value.value })
      end)
      return true
    end,
  })
end
