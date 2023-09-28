{ pkgs, ... }: {
  plugins.lsp.servers.phpactor = {
    enable = true;
    extraOptions = {
      init_options = {
        "language_server_worse_reflection.inlay_hints.enable" = true;
        "language_server_worse_reflection.inlay_hints.params" = true;
        "language_server_configuration.auto_config" = false;
        "code_transform.import_globals" = true;
        "language_server_phpstan.enabled" = true;
        "language_server_phpstan.level" = 7;
        "language_server_phpstan.bin" = "phpstan";
      };
      handlers = {
        "textDocument/inlayHint" = ''
          function(err, result, ...)
            for _, res in ipairs(result) do
              res.label = res.label .. ": "
            end
            vim.lsp.handlers["textDocument/inlayHint"](err, result, ...)
          end
        '';
      };
    };
  };

  extraPackages = with pkgs; [ php82Packages.phpstan ];
}
