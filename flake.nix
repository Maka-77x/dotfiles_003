{
  description = "My personal dotfiles for NixOS";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    stable.url = "github:nixos/nixpkgs/release-24.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    unfree = {
      url = "github:numtide/nixpkgs-unfree";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:WilliButz/preservation";

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-index-database.follows = "nix-index-database";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-compat.follows = "flake-compat";
    };

    inputs.lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "";
      inputs.flake-compat.follows = "flake-compat";
    };

    # vocage.url = "github:proycon/vocage";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    # Use nix-index without having to generate the database locally
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixos";
      inputs.utils.follows = "flake-utils";
    };

    # Flake framework
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };
    flake-schemas.url = "github:gvolpe/flake-schemas";
    ## nix client with schema support: see https://github.com/NixOS/nix/pull/8892
    nix-schema = {
      inputs.flake-schemas.follows = "flake-schemas";
      url = "github:DeterminateSystems/nix-src/flake-schemas";
    };
    flake-utils.url = "github:numtide/flake-utils";

    flake-compat.url = "github:edolstra/flake-compat";
    noshell = {
      url = "github:viperML/noshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Flake Parts module for defining configs
    ez-configs.url = "github:ehllie/ez-configs";

    # Hyprland community tools
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Only used for GRUB theme
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ttf-to-tty = {
      url = "github:Sigmanificient/ttf_to_tty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Generate configs
    nixago = {
      url = "github:nix-community/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Developer environments
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Prolog language server
    swi-lsp-server = {
      url = "github:jamesnvc/lsp_server";
      flake = false;
    };
    nix-colors.url = "github:misterio77/nix-colors";

    # Extra Catppuccin themes
    catppuccin-ohmyrepl = {
      url = "github:catppuccin/ohmyrepl";
      flake = false;
    };
    # Catppuccin Theming
    catppuccin.url = "github:catppuccin/nix";

    # Catppuccin port creation tools
    catppuccin-catwalk = {
      url = "github:catppuccin/catwalk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-whiskers = {
      url = "github:catppuccin/whiskers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extra Catppuccin themes
    # Change to official repo when catppuccin/prismlauncher#6 is merged
    catppuccin-prismlauncher = {
      url = "github:Anomalocaridid/prismlauncher/whiskers";
      flake = false;
    };

    # Catppuccin wallpapers
    catppuccin-fractal-wallpapers = {
      url = "github:psylopneunonym/Catppuccin-Fractal-Wallpapers";
      flake = false;
    };

    # Gaming tweaks
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Fish exercism wrapper
    exercism-cli-fish-wrapper = {
      url = "github:glennj/exercism-cli-fish-wrapper";
      flake = false;
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # yazi plugins
    ## Previewers
    yazi-mime = {
      url = "git+https://gitee.com/DreamMaoMao/mime-ext.yazi.git";
      flake = false;
    };
    glow-yazi = {
      url = "github:Reledia/glow.yazi";
      flake = false;
    };

    miller-yazi = {
      url = "github:Reledia/miller.yazi";
      flake = false;
    };

    exifaudio-yazi = {
      url = "github:Sonico98/exifaudio.yazi";
      flake = false;
    };

    ouch-yazi = {
      url = "github:ndtoan96/ouch.yazi";
      flake = false;
    };

    ## Functional Plugins
    ### Has smart-filter.yazi and full-border.yazi
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    ### Jumping
    relative-motions-yazi = {
      url = "github:dedukun/relative-motions.yazi/0.3.3";
      flake = false;
    };

    ### UI enhancements
    starship-yazi = {
      url = "github:Rolv-Apneseth/starship.yazi";
      flake = false;
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nur,
      nixos-hardware,
      nix-index-database,
      flake-programs-sqlite,
      niri,
      stylix,
      flake-parts,

      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } rec {
      imports = [
        inputs.ez-configs.flakeModule
        inputs.devshell.flakeModule
        # inputs.lix-module.overlays.default
      ];

      ezConfigs = {
        root = ./.;
        globalArgs = {
          inherit inputs;
          inherit (flake) diskoConfigurations;
        };
      };

      # Expose this to use flake directly with Disko
      flake.diskoConfigurations = import ./disko-configurations;

      systems = [ "x86_64-linux" ];

      perSystem =
        args@{ pkgs, inputs', ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;
          packages = import ./scripts args;
          devshells = import ./devshells { inherit pkgs inputs; };
        };
    };
}
