{
  plugins = {
    nix.enable = true;

    lsp.servers.nil-ls.enable = true;

    # treesitter = {
    #   nixvimInjections = true;
    # };

    none-ls = {
      enable = true;
      sources = {
        formatting.alejandra.enable = true;
        diagnostics.statix.enable = true;
        code_actions.statix.enable = true;
      };
    };
  };

  extraFiles = {
    "luasnippets/nix/nix.lua" = builtins.readFile ./snippets.lua;
    "queries/nix/injections.scm" = ''
      ;; extends

      (binding
        attrpath: (attrpath (identifier) @_path)
        expression: [
          (string_expression (string_fragment) @injection.content (#set! injection.language "lua"))
          (indented_string_expression (string_fragment) @injection.content (#set! injection.language "lua"))
        ]
        (#match? @_path "^extraConfigLua(Pre|Post)?$"))


      (binding
        attrpath: (attrpath (identifier) @_path)
        expression: [
          (string_expression (string_fragment) @injection.content (#set! injection.language "vim"))
          (indented_string_expression (string_fragment) @injection.content (#set! injection.language "vim"))
        ]
        (#match? @_path "^extraConfigVim(Pre|Post)?$"))
    '';
  };

  files = {
    "ftplugin/nix.lua" = {
      opts = {
        tabstop = 2;
        softtabstop = 2;
        expandtab = true;
        shiftwidth = 2;
      };
    };
  };
}
