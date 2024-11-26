{ pkgs, lib, ... }:
{
  packages = lib.attrValues { inherit (pkgs) nasm; };
}
