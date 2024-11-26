{ config, ... }:
{
  home.persistence."/persist/${config.home.homeDirectory}" = {
    allowOther = true;
    directories =
      [
        # Default directories I care about
        ".gnupg"
        ".ssh"
        "cloud"
        "repos"
        ".emacs.d"
        "roam"
        "dotfiles"
        "Documents"
        "Downloads"
        "Games"
        "Music"
        "Pictures"
        "Videos"
        "exercism" # Exercism
        ".mozilla" # Firefox data
        "Projects" # Misc. programming
        "quickemu" # quickemu VMs
        "Sync" # Syncthing
        ".tuxpaint" # Tux Paint saves
        ".mix" # Contains hex needed for elixir-ls
        ".unison" # Unison codebase, needs to be persistent as all added code ends up there
        ".steam"
      ]
      ++ map (dir: ".config/${dir}") [
        "nicotine"
        "Signal"
        "Nextcloud"
        "emacs"
        "doom"

        "lutris"
        "maestral"
        "rclone"
        "unity3d"

        "GIMP" # GIMP settings
        "legcord" # armcord user data
        "exercism" # Exercism API key
        "keepassxc" # KeePassXC settings
        "LanguageTool" # LanguageTool settings
        "libreoffice" # Libreoffice settings
        "spotify" # Spotify user data
        "strawberry" # Strawberry settings
        "syncthing" # Syncthing settings
        "FreeTube" # Freetube user data
      ]
      ++ map (dir: ".cache/${dir}") [
        "tealdeer"
        "keepassxc"
        "nix"
        "starship"
        "nix-index"
        "mozilla"
        "zsh"
        "nvim"
        "spotify" # Spotify cache
        "lutris" # Lutris banner cache
      ]
      ++ map (dir: ".local/share/${dir}") [
        ".keepass"
        ".password-store"
        ".ssh"
        "direnv"
        "TelegramDesktop"
        "PrismLauncher"
        "nicotine"
        "maestral"
        "lutris" # Lutris runtime data
        "PrismLauncher" # Prism Launcher data
        "Steam" # Steam games and save data
        "com.yubico.authenticator" # Yubico auth settings (may have secrets?)
        "strawberry" # Strawberry cache
        "Tabletop Simulator" # Tabletop Simulator settings
        "zathura" # Zathura bookmarks, etc.
        "zoxide" # Zoxide history
        "PrismLauncher"
        "bash"
        "containers"
        "direnv/allow"
        "fish"
        "libvirt"
        "mime"
        "mopidy"
      ];
  };
}
