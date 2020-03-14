let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.cmake
      pkgs.clang
      pkgs.clang-analyzer
    ];
    shellHook = ''
      export CMAKE_C_COMPILER=${pkgs.clang}/bin/clang
      export CMAKE_CXX_COMPILER=${pkgs.clang}/bin/clang++
    '';
  }
      #export PATH_CLANGD=${pkgs.clang}/bin/clangd
