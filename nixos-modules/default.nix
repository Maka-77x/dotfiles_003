{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  nixPath = "/run/current-system/nixpkgs";
in
{
  # Import all nix files in directory 
  # Should ignore this file and all non-nix files
  imports =
    map (file: ./. + "/${file}") (
      lib.strings.filter (file: lib.strings.hasSuffix ".nix" file && file != "default.nix") (
        builtins.attrNames (builtins.readDir ./.)
      )
    )
    ++ [
      inputs.lix-module.nixosModules.default
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      inputs.impermanence.nixosModules.impermanence
      inputs.stylix.nixosModules.stylix
      inputs.catppuccin.nixosModules.catppuccin
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      # inputs.spicetify-nix.nixosModules.spicetify
    ];
  environment.systemPackages = with pkgs; [
    anki-bin
    tagainijisho
    goldendict-ng
    qolibri
    # manga-ocr
    clinfo
    util-linux
    nvme-cli
    dmidecode
    inxi
    ethtool
    iw
    iwd
    # iwconfig
    glxinfo
    ly
    # tput
    # mcookie
    linux-firmware
    libva-utils # A collection of utilities and examples for VA-API e.g. vainfo
    mesa # Open-source 3D graphics library
    mesa.drivers # An open source 3D graphics library
    # mesa-demos # Collection of demos and test programs for OpenGL and Mesa
    pciutils # Collection of utilities for inspecting and manipulating PCI devices
    vdpauinfo # Tool to query the Video Decode and Presentation API (VDPAU)  # vaapiVdpau
    # displaylink
  ];
  nix = {
    settings = {
      system-features = [
        # "gccarch-x86-64-v3"
        "gccarch-alderlake"
        "benchmark"
        "ca-derivations"
        "kvm"
        "nixos-test"
        "big-parallel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
        "repl-flake"
        # "cgroup"
      ];
      auto-optimise-store = true;
      repl-overlays = [ ../repl-overlay.nix ]; # Lix-specific setting
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    # Set system registry to flake inputs
    registry = lib.pipe inputs [
      # Remove non flake inputs, which cause errors
      # Flakes have an attribute _type, which equals "flake"
      # while non-flakes lack this attribute
      (lib.filterAttrs (_: flake: lib.attrsets.hasAttr "_type" flake))
      (lib.mapAttrs (_: flake: { inherit flake; }))
    ];
    # For some reason, lix needs this to replace the nix command
    package = pkgs.lix;
    nixPath = [ "nixpkgs=${nixPath}" ];
  };

  nixpkgs = {
    overlays = [
      (import ../pkgs)
      inputs.hyprland-contrib.overlays.default
    ];
    config.allowUnfree = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.extraModprobeConfig = ''
    enable_guc=3 enable_fbc=1 enable_dc=0 enable_pcr=0 enable_rc6=1
  '';

  environment.variables = {
    # VDPAU_DRIVER = "va_gl";
    # LIBVA_DRIVER_NAME = "i915";
  };
  networking.networkmanager = {
    enable = true;
    # wifi.powersave = true;
  };
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.useXkbConfig = true;
  console.earlySetup = true;
  environment.sessionVariables.GDK_SCALE = "1";
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  # List services that you want to enable:
  #Power Optimization
  boot.kernel.sysctl."vm.dirty_writeback_centisecs" = 1500; # 15 seconds

  programs = {
    ssh.startAgent = true;

};

  #Power Settings
  powerManagement = {
    powertop.enable = false;
  };
  # programs.lm_sensor.enable = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
  # use flake's nixpkgs over channels
  system.extraSystemBuilderCmds = ''
    ln -sv ${pkgs.path} $out/nixpkgs
  '';
  systemd.tmpfiles.rules = [ "L+ ${nixPath} - - - - ${pkgs.path}" ];
  # let file managers access trash and remotes
  services.gvfs.enable = true;

  # fancier nix shell
  services.lorri.enable = true;
  services.auto-cpufreq.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      START_CHARGE_THRESH_BAT0 = "60";
      STOP_CHARGE_THRESH_BAT0 = "80";

      CPU_BOOST_ON_BAT = "0";

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      ENERGY_PERFORMANCE_PREFERENCE_ON_BAT = "power";
    };
  };
  services.picom.enable = pkgs.lib.mkForce false;
  services.undervolt = {
    enable = true;
    tempBat = -25;
    # package = pkgs.intel-undervolt;
    # coreOffset = -1;
    # cacheOffset = -1;
    # gpuOffset = -100;
  };
  services.fstrim.enable = true;
  services.fprintd = {
    enable = true;
  };
  services.hardware.bolt.enable = true;
  # programs.iwd.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    # deviceSection = ''
    # Option "DRI" "3"
    # '';
    # useGlamor = true;
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Required for udiskie
  services.udisks2.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
