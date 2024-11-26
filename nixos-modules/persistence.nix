{ ... }:
{
  environment.persistence = {
    "/persist" = {
      hideMounts = true;
      directories = [
        # Necessary system state
        ## NixOS
        "/var/lib/nixos" # Holds state needed for stable uids and gids for users and groups
        ## systemd
        "/var/lib/systemd" # Systemd state directory, used for numerous things
        # Other important things
        "/etc/ly" # Ly default username and desktop, persist entire directory to fix issues with saving session on clean install
        "/etc/NetworkManager/system-connections" # Network connections
        "/etc/nixos" # Nix config
        "/var/lib/clamav" # ClamAV signature database
        "/var/lib/bluetooth"
        "/var/lib/systemd/coredump"
        "/var/lib/iwd"
        "/var/lib/syncthing"
        "/var/lib/containers"
        "/var/lib/fwupd"
        "/var/etc/nix"
        "/var/etc/nixos"
        "/var/db/sudo"
        "/var/lib/pipewire"
      ];
      files = [
        # Necessary system state
        ## systemd
        "/etc/machine-id" # Unique system id for logging, etc.
      ];
    };
  };
  # Needed for root to access bind mounted dirs created by impermanence
  programs.fuse.userAllowOther = true;
}
