{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      clojure
      clojure-lsp
      leiningen # Needed for exercism tests
      ;
  };
}
