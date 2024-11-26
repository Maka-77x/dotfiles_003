{
  lib,
  pkgs,
  config,
  osConfig,
  unstable,
  ...
}:
{
  # Import all nix files in directory 
  # Should ignore this file and all non-nix files
  # Currently, all non-nix files and dirs here are hidden dotfiles
  imports = map (file: ./. + "/${file}") (
    lib.strings.filter (file: !lib.strings.hasPrefix "." file && file != "default.nix") (
      builtins.attrNames (builtins.readDir ./.)
    )
  );

  home = {
    homeDirectory = "/home/${config.home.username}";
    packages =
      [
        # pkgs.xfce.exo
        unstable.signal-desktop
        unstable.telegram-desktop
        unstable.nix-search

        ## credentials / security
        (pkgs.pass.withExtensions (
          exts:
          lib.attrValues {
            inherit (exts)
              pass-otp
              pass-import
              pass-genphrase
              pass-checkup
              pass-update
              ;
          }
        ))
      ]
      ++ lib.attrValues {
        inherit (pkgs)

          # jetbrains-mono

          ## development
          any-nix-shell
          treefmt
          editorconfig-checker
          ## version control
          transmission_4
          git
          git-crypt # sudo ln -s $(which git-crypt) /usr/bin/git-crypt
          git-interactive-rebase-tool
          gitg
          ## debugging

          lldb
          neofetch
          htop
          ugrep
          ripgrep
          ranger
          fd
          libtree # ldd as a tree
          #tldr
          duf
          ncdu
          pstree
          cloc

          gpick
          eyedropper
          eza
          patchelf

          # nix
          nh
          nix-index
          nix-update
          nix-output-monitor
          nix-du
          nix-tree
          nix-init
          nvd
          comma
          manix
          nixpkgs-fmt
          nixpkgs-lint
          nixpkgs-review
          deadnix

          # cnixGLIntel

          nodejs

          yarn
          hugo
          cachix
          v2raya

          # chat
          # pineapple-pictures

          # wayland
          grim
          libsixel
          glide-media-player # video player
          # unstable.decibels       # audio player
          # gnome-calculator # calcualtor
          obsidian
          anki
          loupe # image viewer
          papers # document viewer

          # OVMF
          mokuro
          element-desktop
          # thunderbird
          jan # ai
          qrtool
          dust
          choose # cut/ awk alternative
          procs
          rm-improved
          gping # ping with graph of response times
          mtr # better ping
          zed-editor
          erdtree
          sd
          tailspin
          spacer
          #csvlens
          curlie # httpie for curl
          gpodder # podcast client
          #htmlq
          dogdns
          # zombietrackergps # gps track display
          # inlyne
          difftastic
          anime4k
          quickemu
          # quickgu
          maestral
          maestral-gui
          legcord
          exercism
          firefox
          gimp-with-plugins
          itd
          gh
          keepassxc
          killall
          pavucontrol # Graphical audio controller
          qalculate-gtk
          strawberry
          tree
          tuxpaint
          ventoy
          wl-clipboard
          yubioath-flutter
          ;
      }
      ++ lib.attrValues {
        inherit (pkgs.nodePackages)
          npm
          typescript
          vscode-langservers-extracted
          bash-language-server
          typescript-language-server
          ;
        inherit (pkgs.python312Packages)
          fire
          osc
          fugashi
          jaconv
          loguru
          # numpy
          pillow
          pyperclip
          # torch
          # transformers
          unidic-lite
          grip
          python-lsp-server
          jupyter
          black
          pyflakes
          isort
          # pynose
          pytest
          jsbeautifier
          ;
      };
    sessionVariables = {
      # Some things require $EDITOR to be a single command with no args
      EDITOR = "xdg-open";
      VISUAL = "$EDITOR";
      PAGER = "bat";
      MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --plain --language=man'";
      LIBVA_DRIVER_NAME = "i915";
    };

    # DON'T TOUCH
    # Use system-level stateVersion
    stateVersion = osConfig.system.stateVersion;
  };

  programs = {
    nix-index = {
      enable = true;
      symlinkToCacheHome = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      # enableNushellIntegration = true;
    };
    dircolors.enable = true; # Color ls output
    home-manager.enable = true; # lets Home Manager manage itself
  };

  services.syncthing = {
    enable = true;
    # Reenable after getting a tray service
    # tray.enable = true;
  };

  systemd.user.tmpfiles.rules = [ "L ${config.home.homeDirectory}/nixos - - - - /etc/nixos" ];
  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    telemetry.diagnostics = false;
    telemetry.metrics = false;
    autosave = "on_focus_change";
    cursor_blink = false;
    tab_bar.show = false;
    git.inline_blame.enabled = false;
    indent_guides.enabled = false;
    vim_mode = true;
    projects_online_by_default = false;
    toolbar.quick_actions = false;
    auto_update = false;
    gutter.code_actions = false;
    gutter.folds = false;
    gutter.runnables = false;
    gutter.line_numbers = false;
    assistant.button = false;
    collaboration_panel.button = false;
    chat_panel.button = false;
    notification_panel.button = false;
    terminal.button = false;
    terminal.shell.program = "fish";
    project_panel.button = false;
    outline_panel.button = false;
    features.inline_completion_provider = "none";
    lsp.rust-analyzer.binary.path = "rust-analyzer";
    lsp.rust-analyzer.initialization_options = {
      check.overrideCommand = [
        "x"
        "remote"
        "ra-check"
      ];
      procMacro.enable = false;
      diagnostics.disabled = [
        "unresolved-proc-macro"
        "macro-error"
      ];
      cargo.buildScripts.enable = false;
    };
    use_system_path_prompts = false;
    assistant = {
      version = "1";
      provider = {
        default_model = "claude-3-5-sonnet";
        name = "anthropic";
        low_speed_timeout_in_seconds = 60;
      };
    };
    language_servers = [ "rust-analyzer" ];
    slash_commands.docs.enabled = true;
  };
}
