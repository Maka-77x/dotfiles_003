{ pkgs, lib, ... }:
{
  packages = lib.attrValues { inherit (pkgs) mars-mips; };
}
