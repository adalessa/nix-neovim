{pkgs, ...}: let
  heler = import ../../../helper.nix;
  inherit (heler) luaAction;
in {
  extraPlugins = with pkgs.extraVimPlugins; [telescope-graphql php-lsp-utils];
  keymaps = [
    {
      mode = "n";
      key = "<leader>pm";
      options.desc = "Search Mutation and query";
      lua = true;
      action = luaAction ''
        local files = {}
        local mutationPath = vim.fn.findfile("_mutation.yaml", "config/graphql")
        local queryPath = vim.fn.findfile("_query.yaml", "config/graphql")
        if mutationPath ~= "" then
          table.insert(files, vim.fn.getcwd() .. "/" .. mutationPath)
        end
        if queryPath ~= "" then
          table.insert(files, vim.fn.getcwd() .. "/" .. queryPath)
        end
        if #files == 0 then
          print("No mutation or query found")
          return
        end

        local action_state = require "telescope.actions.state"
        local actions = require "telescope.actions"
        require('telescope').extensions.graphql.definitions({
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

              require('php-lsp-utils').go_to("phpactor", fqn_class, method)
            end)
            return true
          end,
        })
      '';
    }
  ];
}
