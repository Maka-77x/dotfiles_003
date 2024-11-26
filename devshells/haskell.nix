{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      cabal-install # Package manager
      ghc # Compiler
      haskell-language-server
      hlint # Linter
      ormolu # Formatter
      stack # Package manager
      ;
  };
}
