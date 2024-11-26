{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      perl
      perlnavigator # Language server
      ;
    inherit (pkgs.perl540Packages) PerlCritic PerlTidy;
  };
}
