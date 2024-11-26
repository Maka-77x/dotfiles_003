{ pkgs, lib, ... }:
{
  home.packages = lib.attrValues {
    inherit (pkgs)
      hunspell # Required for spellcheck
      # hunspellDicts.en-gb-ise # American English spellcheck dictionary
      languagetool # spelling, style. and grammer checker
      libreoffice-fresh
      ;
  };
}
