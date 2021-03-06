{ pkgs ? import <nixpkgs> {} }:

let env = pkgs.haskellPackages.ghcWithPackages(p: with p; [
    Cabal cabal-install hlint text hspec QuickCheck brick
  ]);
in pkgs.stdenv.mkDerivation {
  name = "hug";
  version = "0.1.0.0";
  src = ./.;
  buildInputs = [ env ];
  shellHook = ''
    export NIX_GHC="${env}/bin/ghc"
    export NIX_GHCPKG="${env}/bin/ghc-pkg"
    export NIX_GHC_DOCDIR="${env}/share/doc/ghc/html"
    export NIX_GHC_LIBDIR=$( $NIX_GHC --print-libdir )
  '';
}
