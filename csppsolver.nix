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
  version = "2.4.0";
  subPackages = [ "./cmd/csppsolver" ];

  src = fetchFromGitHub {
    owner = "decred";
    repo = "cspp";
    rev = "v2.4.0";
    hash = "sha256-Io6zJaQO+EDrwiXP0bWrfhQ2dWLtZQ+eCHUrRVBkZdA=";
  };
  proxyVendor = true;
  vendorHash = "sha256-OXLSKtZGNTv+cxyn4A2Px3rDKQXB2Xw4IlIQkDcSX1s=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ gmp mpfr flint3 ];

  ldflags = [ "-s" "-w" ] ++ lib.optionals static [ "-linkmode=external" "-extldflags=-static" ];

  env.CGO_LDFLAGS = "-O2 -g -L${flint3}/lib -lflint -lm";
  env.CGO_ENABLED = 1;
}
