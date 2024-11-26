{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      bats # Needed for exercism tests

      shellcheck # More diagnostics for language server
      shfmt # Formatter
      ;
    inherit (pkgs.nodePackages) bash-language-server;
  };
}
