{ ... }:
{
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # Bluetooth manager
  services.blueman.enable = true;
}
