{ pkgs, ... }: {
  plugins.lsp.servers.phpactor = {
    enable = true;
    filetypes = [ "php" "blade" ];
    extraOptions = {
      init_options = {
        "language_server_worse_reflection.inlay_hints.enable" = true;
        "language_server_worse_reflection.inlay_hints.params" = true;
        "language_server_configuration.auto_config" = false;
        "code_transform.import_globals" = true;
        "prophecy.enabled" = true;
        "language_server_phpstan.enabled" = true;
        "language_server_phpstan.level" = 7;
        "language_server_phpstan.bin" = "phpstan";
        "php_code_sniffer.bin" = "phpcs";
        "indexer.exclude_patterns" = [
          "/vendor/**/Tests/**/*"
          "/vendor/**/tests/**/*"
          "/var/cache/**/*"
          "/vendor/composer/**/*"
        ];
      };
      handlers = {
        "textDocument/inlayHint".__raw = ''
          function(err, result, ...)
            for _, res in ipairs(result) do
              res.label = res.label .. ": "
            end
            vim.lsp.handlers["textDocument/inlayHint"](err, result, ...)
          end
        '';
      };
    };

    onAttach.function = ''
      vim.api.nvim_buf_create_user_command(bufnr, "LspPhpactorReindex", function()
        vim.lsp.buf_notify(bufnr, "phpactor/index/reindex", {})
      end, {})
    '';
  };

  extraPackages = with pkgs; [ php82Packages.phpstan php82Packages.phpcs ];
}
