{ pkgs
, lib
, stdenv
, fetchFromGitHub
, buildGoModule
, flint3
, gmp
, mpfr
, pkg-config
, static ? stdenv.targetPlatform.isStatic,
}:

buildGoModule {
  pname = "csppsolver";
  version = "2.2.0";
  subPackages = [ "./cmd/csppsolver" ];

  src = fetchFromGitHub {
    owner = "decred";
    repo = "cspp";
    rev = "v2.2.0";
    hash = "sha256-oUme+rRbuyDjAeH18fZ0OuM2elwFnYbxS8wJ2mbmDJA=";
  };
  proxyVendor = true;
  vendorHash = "sha256-OXLSKtZGNTv+cxyn4A2Px3rDKQXB2Xw4IlIQkDcSX1s=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ gmp mpfr flint3 ];

  ldflags = [ "-s" "-w" ] ++ lib.optionals static [ "-linkmode=external" "-extldflags=-static" ];

  CGO_LDFLAGS = "-O2 -g -L${flint3}/lib -lflint -lm";
  CGO_ENABLED = 1;
}
