{ lib, config, ... }:
with lib;
let
  cfg = config.languages.php.phpactor;
in
{
  options = {
    languages.php.phpactor = {
      enable = mkEnableOption "phpactor";
      phpunit.enable = mkEnableOption "phpunit";
      prophecy.enable = mkEnableOption "prophecy";
      auto_config = mkEnableOption "auto_config";
      phpcs = {
        enable = mkEnableOption "phpcs";
        bin = lib.mkOption {
          type = lib.types.str; # Specify the type as string
          default = "%project_root%/vendor/bin/phpcs"; # Set the default value
          description = "Binary for phpcs";
        };
      };
      phpstan = {
        enable = mkEnableOption "phpstan";
        bin = lib.mkOption {
          type = lib.types.str; # Specify the type as string
          default = "%project_root%/vendor/bin/phpstan"; # Set the default value
          description = "Binary for phpstan";
        };
        level = lib.mkOption {
          type = lib.types.str; # Specify the type as string
          default = "5"; # Set the default value
          description = "Level for phpstan";
        };
      };
    };
  };
  config = mkIf cfg.enable {
    plugins.lsp.servers.phpactor = {
      enable = true;
      filetypes = [
        "php"
        "blade"
      ];
      extraOptions = {
        init_options = {
          "language_server_configuration.auto_config" = cfg.auto_config;
          "language_server_worse_reflection.inlay_hints.enable" = true;
          "language_server_worse_reflection.inlay_hints.types" = false;
          "language_server_worse_reflection.inlay_hints.params" = true;
          "code_transform.import_globals" = true;
          "prophecy.enabled" = cfg.prophecy.enable;
          "phpunit.enabled" = cfg.phpunit.enable;
          "indexer.exclude_patterns" = [
            "/vendor/**/Tests/**/*"
            "/vendor/**/tests/**/*"
            "/var/cache/**/*"
            "/vendor/composer/**/*"
            "/vendor/composer/**/*"
            "/vendor/laravel/fortify/workbench/**/*"
            "/vendor/filament/forms/.stubs.php"
            "/vendor/filament/notifications/.stubs.php"
            "/vendor/filament/tables/.stubs.php"
            "/vendor/filament/actions/.stubs.php"
            "/storage/framework/cache/**/*"
            "/storage/framework/views/**/*"
          ];
          "php_code_sniffer.enabled" = cfg.phpcs.enable;
          "php_code_sniffer.bin" = cfg.phpcs.bin;
          "language_server_phpstan.enabled" = cfg.phpstan.enable;
          "language_server_phpstan.level" = cfg.phpstan.level;
          "language_server_phpstan.bin" = cfg.phpstan.bin;
          "language_server_phpstan.mem_limit" = "2048M";
        };
        handlers = {
          "textDocument/inlayHint".__raw = ''
            function(err, result, ...)
              for _, res in ipairs(result or {}) do
                if res.kind == 2 then
                  res.label = res.label .. ":"
                end
                res.label = res.label ..  " "
              end
              vim.lsp.handlers["textDocument/inlayHint"](err, result, ...)
            end
          '';

          # Remove the namespace error on tests for using pest
          "textDocument/publishDiagnostics".__raw = ''
            function(err, result, ...)
              if vim.endswith(result.uri, "Test.php") then
                result.diagnostics = vim.tbl_filter(function(diagnostic)
                  return not vim.startswith(diagnostic.message, 'Namespace should probably be "Tests')
                end, result.diagnostics)
              end
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ...)
            end
          '';
        };
        before_init.__raw = ''
          function(params, config)
            -- check if there is a phpstan file and get the level from there
            config.init_options["language_server_phpstan.level"] = vim.fn.filereadable("phpstan.neon.dist") == 1 and vim.fn.systemlist("grep -oP 'level: \\K[0-9]+' phpstan.neon.dist", {}, 0)[1] or config.init_options["language_server_phpstan.level"]
          end
        '';
      };

      onAttach.function = ''
        vim.api.nvim_buf_create_user_command(bufnr, "LspPhpactorReindex", function()
          vim.lsp.buf_notify(bufnr, "phpactor/index/reindex", {})
        end, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspPhpactorDumpConfig", function()
          local results, _ = vim.lsp.buf_request_sync(0, "phpactor/debug/config", {["return"]=true})
          vim.print(results)
        end, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspPhpactorStatus", function()
          local results, _ = vim.lsp.buf_request_sync(0, "phpactor/status", {["return"]=true})
          vim.print(results)
        end, {})
      '';
    };
  };
}
