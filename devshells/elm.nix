{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs.elmPackages)
      elm
      elm-test # Diagnostics and running tests
      elm-format
      elm-language-server
      ;
  };
}
