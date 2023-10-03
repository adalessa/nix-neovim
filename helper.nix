{
  mkLuaKeymap = { action, desc }: {
    lua = true;
    silent = true;
    desc = desc;
    action = "function() ${action} end";
  };
  luaAction = str: "function() ${str} end";
}
