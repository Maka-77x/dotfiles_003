{ pkgs, lib, ... }:
{
  packages = lib.attrValues { inherit (pkgs) nim nimlsp; };
}
