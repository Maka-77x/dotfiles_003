{ pkgs, ... }:
let
  user = "parrmic";
  persistDir = "/persist";
  passwordDir = "${persistDir}/passwords";
  inherit (builtins) mapAttrs;
in
{
  fonts = {
    fontconfig = {
      # Whether to enable fontconfig configuration. This will, for
      # example, allow fontconfig to discover fonts and configurations
      # installed through home.packages and nix-env.
      enable = true;

      # Enable font antialiasing.
      antialias = true;

      #  Enable font hinting. Hinting aligns glyphs to pixel boundaries
      # to improve rendering sharpness at low resolution.
      hinting.enable = true;
      # Set the defalt fonts. This was taken from raf,
      # many thanks.
      defaultFonts =
        let
          common = [
            # "Iosevka Nerd Font"
            "Symbols Nerd Font"
            "Noto Color Emoji"
          ];
        in
        mapAttrs (_: fonts: fonts ++ common) {
          serif = [ "Cousine" ];
          sansSerif = [ "Lexend" ];
          emoji = [ "Noto Color Emoji" ];
          monospace = [ "Monofur" ];
        };
    };
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          # "3270"
          "FiraMono"
          "Agave"
          "AnonymousPro"
          # "Arimo"
          "IBMPlexMono"
          "CascadiaCode"
          "ComicShannsMono"
          "Cousine"
          # "DaddyTimeMono"
          "DejaVuSansMono"
          "EnvyCodeR"
          "FantasqueSansMono"
          # "Go-Mono"
          # "Gohu"
          "Hack"
          # "Hasklig"
          "Hermit"
          "iA-Writer"
          # "Inconsolata"
          # "InconsolataGo"
          # "InconsolataLGC"
          # "IntelOneMono"
          # "Iosevka"
          # "IosevkaTerm"
          # "JetBrainsMono"
          "Lekton"
          # "LiberationMono"
          # "Lilex"
          "Meslo"
          "Monoid"
          "Mononoki"
          "MPlus"
          # "Noto"
          "OpenDyslexic"
          "Overpass"
          # "ProFont"
          # "RobotoMono"
          "SourceCodePro"
          "ShareTechMono"
          "SpaceMono"
          "Terminus"
          "Tinos"
          # "Ubuntu"
          # "UbuntuMono"
          "VictorMono"
          "AurulentSansMono"
          "BigBlueTerminal"
          "BitstreamVeraSansMono"
          "CodeNewRoman"
          "DroidSansMono"
          # "HeavyData"
          "Monofur"
          "ProggyClean"
        ];
      })
      unifont
      unifont_upper
      rPackages.fontawesome
      wine64Packages.fonts
      winePackages.fonts
      wineWowPackages.fonts
      corefonts
      vistafonts
      # noto-fonts
      noto-fonts-emoji
      junicode
    ];
    # packages = with pkgs; [
    #   material-icons
    #   material-design-icons
    #   papirus-icon-theme
    #   (nerdfonts.override {
    #     fonts = [
    #       "Iosevka"
    #       "JetBrainsMono"
    #       "ComicShannsMono"
    #       "OpenDyslexic"
    #       "Hack"
    #       "FiraCode"
    #       "FiraMono"
    #       "CascadiaCode"
    #       "IosevkaNerdFont"
    #       "Meslo"
    #       "MPlus"
    #       "SourceCodePro"
    #       "NerdFontsSymbolsOnly"
    #     ];
    #   })
    #   cascadia-code
    #   powerline-fonts
    #   dejavu_fonts
    #   # OpenDyslexic
    #   # ComicShanns
    #   # ComicNeue
    #   # ComicNeue-Angular
    #   Lexend
    #   SeriousSans
    #   texlive-opentype
    #   texlive-truetype
    #   lexend
    #   noto-fonts
    #   noto-fonts-cjk-sans
    #   noto-fonts-cjk-serif
    #   noto-fonts-color-emoji
    #   corefonts
    #   # defaults worth keeping
    #   dejavu_fonts
    #   freefont_ttf
    #   gyre-fonts
    #   liberation_ttf # for PDFs, Roman
    #   unifont
    #   roboto

    #   # programming fonts
    #   sarasa-gothic
    #   b612 # high legibility
    #   work-sans
    #   comic-neue
    #   inter
    #   lato
    #   # emojis
    #   twemoji-color-font
    #   openmoji-color
    #   openmoji-black
    # ];
    fontDir = {
      # Whether to create a directory with links to all fonts in
      # /run/current-system/sw/share/X11/fonts
      enable = true;

      # Whether to decompress fonts in
      # /run/current-system/sw/share/X11/fonts
      decompressFonts = false;
    };
  };

  users.users = {
    ${user} = {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user
        "networkmanager" # Change network settings
      ];
      hashedPasswordFile = "${passwordDir}/${user}";
    };
    root.hashedPasswordFile = "${passwordDir}/root";
  };

  # Ensure certain directories exist and have necessary permissions
  systemd.tmpfiles.rules = [
    "Z ${persistDir}/etc/nixos                -    ${user} users"
    "d ${persistDir}/home/${user}             0755 ${user} users"
    "Z ${persistDir}/home/${user}             -    ${user} users"
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  ];

  # /persist is needed for boot because it contains password hashes
  # TODO: See if this line can be moved to disko config
  fileSystems.${persistDir}.neededForBoot = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  environment.systemPackages = with pkgs; [
    # aleo-fonts
    # manga-ocr
    # whatmp3
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
    gh
    maestral
    maestral-gui
  ];

  # Need to enable fish at system level to use as shell
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };
}
