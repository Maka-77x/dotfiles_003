{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      gradle # Needed for exercism tests
      jdk # Java development kit
      jdt-language-server
      ;
  };
}
