{
  lib,
  config,
  helpers,
  ...
}:
{
  options = {
    tools.toggleterm.terminals = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            cmd = lib.mkOption { type = lib.types.str; };
            dir = helpers.mkNullOrStr "";
            direction = lib.mkOption { type = lib.types.str; };
            on_open = helpers.mkNullOrOption helpers.nixvimTypes.rawLua "";
            on_close = helpers.mkNullOrOption helpers.nixvimTypes.rawLua "";
            keymap = lib.mkOption { type = lib.types.str; };
          };
        }
      );
      default = [ ];
    };
  };
  config = {
    extraConfigLua = lib.mkIf (config.tools.toggleterm.terminals != [ ]) ''
      do
        local __terminals = ${helpers.toLuaObject config.tools.toggleterm.terminals}
        for i, _terminal in ipairs(__terminals) do
          local Terminal = require("toggleterm.terminal").Terminal
          local term = Terminal:new({
            cmd = _terminal.cmd,
            dir = _terminal.dir,
            direction = _terminal.direction,
            on_open = _terminal.on_open,
            on_close = _terminal.on_close,
          })
          vim.keymap.set("n", _terminal.keymap, function()
            term:toggle()
          end, {})
        end
      end
    '';
  };
}
