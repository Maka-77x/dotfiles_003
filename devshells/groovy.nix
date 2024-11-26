{ pkgs, lib, ... }:
{
  packages = lib.attrValues {
    inherit (pkgs)
      gradle_6 # Needed for exercism tests, previous version needed for compatibility
      groovy
      jdk # Java development kit
      ;
  };
}
