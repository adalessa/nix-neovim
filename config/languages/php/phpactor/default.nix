{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.languages.php.phpactor;
  packages =
    optionals config.languages.php.phpactor.phpcs.enable [pkgs.php82Packages.phpcs]
    ++ optionals config.languages.php.phpactor.phpstan.enable [pkgs.php82Packages.phpstan];

  init_options =
    {
      "language_server_configuration.auto_config" = false;
      "language_server_worse_reflection.inlay_hints.enable" = true;
      "language_server_worse_reflection.inlay_hints.params" = true;
      "code_transform.import_globals" = true;
      "prophecy.enabled" = true;
      "phpunit.enabled" = true;
      "indexer.exclude_patterns" = [
        "/vendor/**/Tests/**/*"
        "/vendor/**/tests/**/*"
        "/var/cache/**/*"
        "/vendor/composer/**/*"
      ];
    }
    // (
      if config.languages.php.phpactor.phpstan.enable
      then {
        "language_server_phpstan.enabled" = true;
        "language_server_phpstan.level" = "7";
        "language_server_phpstan.bin" = "phpstan";
      }
      else {}
    )
    // (
      if config.languages.php.phpactor.phpcs.enable
      then {
        "php_code_sniffer.enabled" = true;
        "php_code_sniffer.bin" = "phpcs";
      }
      else {}
    );
in {
  options = {
    languages.php.phpactor = {
      enable = mkEnableOption "phpactor";
      phpcs.enable = mkEnableOption "phpcs";
      phpstan.enable = mkEnableOption "phpstan";
    };
  };
  config = mkIf cfg.enable {
    plugins.lsp.servers.phpactor = {
      enable = true;
      filetypes = ["php" "blade"];
      extraOptions = {
        inherit init_options;
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

    extraPackages = packages;
  };
}
