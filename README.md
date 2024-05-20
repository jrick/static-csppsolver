# static-csppsolver

This repository contains a [Nix](https://nixos.org/) flake to build a
staticly-linked
[csppsolver](https://pkg.go.dev/decred.org/cspp/v2/cmd/csppsolver) that can be
deployed without installing Flint or other dependencies.  Currently, only
linux-x86_64 host and target platforms are supported.

To build `csppsolver` yourself:

1. [Install Nix](https://nixos.org/download/) (unnecessary on NixOS)
2. [Enable Flakes](https://nixos.wiki/wiki/flakes)
3. From this repository checkout, run:

```
$ nix build
```

The resulting `csppsolver` executable will be available under
`./result/bin/csppsolver` in the current directory.

# Downloads

Precompiled `csppsolver` executables are available under
[releases](https://github.com/jrick/static-csppsolver/releases).

## License

static-csppsolver is licensed under a permissive ISC License.
