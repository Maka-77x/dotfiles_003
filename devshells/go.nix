{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      delve # Debugger
      go
      golangci-lint
      golangci-lint-langserver # Language Server with linting
      gopls # Language Server
      ;
  };
}
