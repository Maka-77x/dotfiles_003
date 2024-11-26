{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      gnumake # Needed for exercism tests
      cmake # Needed for exercism tests
      fortls # Language server
      gfortran # Fortran compiler
      ;
  };
}
