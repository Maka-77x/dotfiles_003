{ diskoConfigurations, inputs, ... }:
{
  networking.hostName = "desktop";
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./hardware-settings.nix
    diskoConfigurations.desktop
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc-laptop
  ];
}
