final: prev: {
  # Custom-written packages
  custom = {
    # custom locking script
    lockman = final.callPackage ./lockman { };
    # custom screenshot script
    screenshot = final.callPackage ./screenshot { };
    manga-ocr = final.callPackage ./manga-ocr { };
    whatmp3 = final.callPackage ./whatmp3 { };
    aleo-fonts = final.callPackage ./aleo-fonts.nix { };
  };
}
