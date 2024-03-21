{ lib,
  icu,
  qmake,
  fetchFromGitHub,
  fetchgit,
  stdenv,
  gcc11Stdenv,
  pkg-config,
  qtbase,
  qtconnectivity,
  qtgamepad,
  qtgraphicaleffects,
  qtlocation,
  qtquickcontrols2,
  qtserialport,
  wrapQtAppsHook,
  mkDerivation,
}:

mkDerivation rec {
  pname = "vesc-tool";
  version = "6.02";

  src = fetchFromGitHub {
    owner = "lukash";
    repo = "vesc_tool";
    rev = "release_6_02.1";
    sha256 = "Vo2TPtt094xhijW1k6eiO4+UWMxpROahv8O/FJ9W3as=";
  };

  nativeBuildInputs = [
    pkg-config
    qmake
    wrapQtAppsHook
  ];

  buildInputs = [
    qtconnectivity
    qtgamepad
    qtgraphicaleffects
    qtlocation
    qtquickcontrols2
    qtserialport
  ];

  qmakeFlags = [
    "-config release"
    "CONFIG+=release_lin"
    "CONFIG+=exclude_fw"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp build/lin/vesc_tool_6.02 $out/bin/vesc_tool
  '';
}
