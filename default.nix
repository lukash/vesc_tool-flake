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
  version = "6.06";

  src = fetchFromGitHub {
    owner = "lukash";
    repo = "vesc_tool";
    rev = "release_6_06";
    sha256 = "+rvYAyxztOhJ4O74zjtyPt5CUxwff7UE2Ww9UTSu73g=";
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
    cp build/lin/vesc_tool_6.06 $out/bin/vesc_tool
  '';
}
