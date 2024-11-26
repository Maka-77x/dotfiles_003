{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      crystal
      crystalline # crystal lsp
      ;
  };
}
