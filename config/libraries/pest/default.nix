{
  globals = {
    "dispatch_compilers" = {
      "./vendor/bin/pest" = "pest";
    };
  };

  extraFiles = {
    "compiler/pest.vim".source = ./compiler.vim;
  };
}
