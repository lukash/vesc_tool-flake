{
    inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-23.11;
    inputs.flake-utils.url = github:numtide/flake-utils;

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = nixpkgs.legacyPackages.${system};
            vesc_tool = pkgs.libsForQt5.callPackage ./default.nix {};
        in {
            packages = {
                default = vesc_tool;
            };
            devShells.default = pkgs.mkShell {
                inputsFrom = [ vesc_tool ];

                nativeBuildInputs = [
                    pkgs.makeShellWrapper
                ];

                # https://discourse.nixos.org/t/python-qt-woes/11808/10
                shellHook = ''
                    setQtEnvironment=$(mktemp --suffix .setQtEnvironment.sh)
                    echo "shellHook: setQtEnvironment = $setQtEnvironment"
                    makeShellWrapper "/bin/sh" "$setQtEnvironment" "''${qtWrapperArgs[@]}"
                    sed "/^exec/d" -i "$setQtEnvironment"
                    source "$setQtEnvironment"
                '';
            };
        }
    );
}
