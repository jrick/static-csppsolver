{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
          pkgsStatic = pkgs.pkgsStatic;
        in {
          csppsolver = pkgs.pkgsCross.musl64.callPackage ./csppsolver.nix {
            inherit (pkgsStatic) gmp mpfr;
            flint3 = (pkgsStatic.flint3.override {
              withBlas = false;
              withNtl = false;
            }).overrideAttrs { doCheck = false; };
          };
        }
      );

    in {
      inherit packages;

      defaultPackage = forAllSystems (system: self.packages.${system}.csppsolver);
    };
}
