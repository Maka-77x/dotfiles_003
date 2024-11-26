{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs) nodejs;
    inherit (pkgs.nodePackages) typescript-language-server;
  };
}
