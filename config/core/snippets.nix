{ helpers, ... }:
{
  plugins.luasnip = {
    enable = true;

    settings = {
      history = true;
      updateevents = "TextChanged,TextChangedI";
      enable_autosnippets = true;
    };

    fromLua = [ { } ];
  };

  keymaps = [
    {
      mode = [
        "i"
        "s"
      ];
      key = "<c-k>";
      action = helpers.mkRaw ''
        function()
          local ls = require('luasnip')
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          end
        end
      '';
      options.silent = true;
    }
    {
      mode = [
        "i"
        "s"
      ];
      key = "<c-j>";
      action = helpers.mkRaw ''
        function()
          local ls = require('luasnip')
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end
      '';
      options.silent = true;
    }
    {
      mode = [
        "i"
        "s"
      ];
      key = "<c-l>";
      action = helpers.mkRaw ''
        function()
          local ls = require('luasnip')
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end
      '';
      options.silent = true;
    }
  ];
}
