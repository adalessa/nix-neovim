{
  mkLuaKeymap = {action, desc}: {
    lua = true;
    silent = true;
    desc = desc;
    action = "function() ${action} end";
  };

  toLua = str: "lua <<EOF\n${str}\nEOF\n";
}
