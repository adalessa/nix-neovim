{
  plugins = {
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    nvim-cmp = {
      enable = true;
      mapping = {
        "<c-y>" = "cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })";
        "<c-d>" = "cmp.mapping.scroll_docs(-4)";
        "<c-f>" = "cmp.mapping.scroll_docs(4)";
        "<c-space>" = "cmp.mapping.complete()";
        "<c-e>" = {
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.close()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end
          '';
          modes = [ "i" "s" ];
        };
        "<c-n>" = {
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.choice_active() then
                luasnip.change_choice(1)
              else
                fallback()
              end
            end
          '';
          modes = [ "i" "s" ];
        };
        "<c-p>" = "cmp.mapping.select_prev_item()";
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };
  };
}
