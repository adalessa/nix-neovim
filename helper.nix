{
  mkLuaKeymap = {
    action,
    desc,
  }: {
    lua = true;
    silent = true;
    inherit desc;
    action = "function() ${action} end";
  };
  luaAction = str: "function() ${str} end";
}
