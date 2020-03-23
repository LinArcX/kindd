let
  pkgs = import <nixpkgs> {};
  unstable = import (fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz) {};
  pkgs-2020-03-23 = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/793c1b5c72abbfed2f98add0811a022fc713dbf3.tar.gz) {};
in
  pkgs-2020-03-23.clangStdenv.mkDerivation rec {
    pname   = "captain-ballard";
    version = "1.0.0";
    name    = "${pname}${version}";

    nativeBuildInputs = [
      pkgs.pkg-config
      unstable.cmake

      pkgs-2020-03-23.qt5.wrapQtAppsHook
      pkgs-2020-03-23.qt5.qtdeclarative
    ];

    buildInputs = [
      pkgs-2020-03-23.lldb
      pkgs-2020-03-23.clang-tools
      pkgs-2020-03-23.clang-analyzer

      pkgs-2020-03-23.man
      pkgs-2020-03-23.man-pages
      pkgs-2020-03-23.clang-manpages
      pkgs-2020-03-23.posix_man_pages

      pkgs-2020-03-23.polkit_gnome
      pkgs-2020-03-23.qt5.qtbase
      pkgs-2020-03-23.qt5.qtsvg
      pkgs-2020-03-23.qt5.qtquickcontrols
      pkgs-2020-03-23.qt5.qtquickcontrols2
      pkgs-2020-03-23.qt5.qtgraphicaleffects
    ];

    FONTCONFIG_FILE = "${pkgs-2020-03-23.fontconfig.out}/etc/fonts/fonts.conf";
    LOCALE_ARCHIVE = "${pkgs-2020-03-23.glibcLocales}/lib/locale/locale-archive";

    shellHook = ''
      export NAME=${pname}
      export CMAKE=${unstable.cmake}/bin/cmake
      export CLANGD=${pkgs-2020-03-23.clang-tools}/bin/clangd
    '';
  }

      #pkgs-2020-03-23.qt5.full
