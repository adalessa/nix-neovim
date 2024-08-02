{
  pkgs,
  inputs,
  helpers,
  ...
}:
let
  bladeGrammar = pkgs.tree-sitter.buildGrammar {
    language = "blade";
    version = "0.9.2";
    src = inputs.blade-treesitter;
  };
in
{
  plugins = {
    treesitter = {
      languageRegister.blade = "blade";
      grammarPackages = [ bladeGrammar ];
    };

    none-ls.sources.formatting.blade_formatter = {
      enable = true;
      package = pkgs.blade-formatter;
    };

    lsp.servers.emmet-ls.filetypes = [ "blade" ];
  };

  extraFiles = {
    "queries/blade/highlights.scm".source = ./highlights.scm;
    "queries/blade/injections.scm".source = ./injections.scm;
    "after/queries/html/injections.scm".text = ''
      ;; extends
      ; AlpineJS attributes
      (attribute
        (attribute_name) @_attr
          (#lua-match? @_attr "^x%-%l")
          (#not-any-of? @_attr "x-teleport" "x-ref" "x-transition")
        (quoted_attribute_value
          (attribute_value) @injection.content)
        (#set! injection.language "javascript"))

      ; Blade escaped JS attributes
      ; <x-foo ::bar="baz" />
      (element
        (_
          (tag_name) @_tag
            (#lua-match? @_tag "^x%-%l")
        (attribute
          (attribute_name) @_attr
            (#lua-match? @_attr "^::%l")
          (quoted_attribute_value
            (attribute_value) @injection.content)
          (#set! injection.language "javascript"))))

      ; Blade PHP attributes
      ; <x-foo :bar="$baz" />
      (element
        (_
          (tag_name) @_tag
            (#lua-match? @_tag "^x%-%l")
          (attribute
            (attribute_name) @_attr
              (#lua-match? @_attr "^:%l")
            (quoted_attribute_value
              (attribute_value) @injection.content)
            (#set! injection.language "php_only"))))
    '';
  };

  filetype.pattern.".*%.blade%.php" = "blade";

  autoGroups = {
    blade = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [ "*.blade.php" ];
      group = "blade";
      callback = helpers.mkRaw ''
        function()
          vim.bo.filetype = "php"
          vim.cmd([[
            setlocal indentexpr =
            setlocal autoindent
            setlocal smartindent
          ]])
        end
      '';
    }
    {
      event = [ "LspAttach" ];
      pattern = [ "*.blade.php" ];
      callback = helpers.mkRaw ''
        function(args)
          vim.schedule(function()
            local client = vim.lsp.get_active_clients({ name = "phpactor" })[1]
            if (client and vim.lsp.buf_is_attached(args.buf, client.id)) then
              vim.api.nvim_buf_set_option(args.buf, "filetype", "blade")
              vim.api.nvim_buf_set_option(args.buf, "syntax", "blade")
            end
          end)
        end
      '';
    }
  ];
}
