{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo # Show workspaces in a grid
      hyprtrails # Give moving windows trails
      hyprwinwrap # Set an arbitrary program as a wallpaper
    ];
    settings = {
      exec-once = lib.flatten [
        "eww open bar"
        (lib.getExe pkgs.hyprland-autoname-workspaces)
        "legcord -silent"
        # "steam -silent"
        # cava wallpaper
        "wezterm --config window_background_opacity=0 start --class hyprwinwrap -- cava"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 16;
        border_size = 4;
        "col.active_border" = "0xee$lavenderAlpha 0xee$accentAlpha 45deg";
        "col.inactive_border" = "0xaa$overlay0Alpha 0xaa$mantleAlpha 45deg";

        layout = "dwindle";
        # allow_tearing = true;
        # resize_on_border = true;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          # vibrancy = 0.2;
          popups = true;
          popups_ignorealpha = 0.2;
          new_optimizations = false;
        };

        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_range = 8;
        shadow_render_power = 3;
        "col.shadow" = "$base";
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master.new_status = "master";

      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      gestures = {
        # workspace_swipe = true;
        # workspace_swipe_forever = true;
      };

      group = {
        "col.border_active" = "0xee$yellowAlpha";
        "col.border_inactive" = "0xaa$overlay0Alpha 0xaa$yellowAlpha 45deg";
        "col.border_locked_active" = "0xee$yellowAlpha 0xee$redAlpha 45deg";
        "col.border_locked_inactive" = "0xaa$overlay0Alpha 0xaa$redAlpha 45deg";
        groupbar = {
          # font_size = 11;
          text_color = "$text";
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = true;
        swallow_regex = "^(org.wezfurlong.wezterm)$";
      };

      # Window rules
      windowrulev2 = [
        "float, class:^(wlogout|pavucontrol|nmtui)$"
        "workspace 1, class:^(lutris)$"
        "workspace 2, class:^([Ff]irefox)$"
        "workspace 3, class:^(filemanager)$"
        "workspace 4 silent, class:^(legcord)$"
        "workspace 5, title:^(Spotify.*)$"
        # Inhibit idle on fullscreen programs where keyboard/mouse may not be used for a while
        "idleinhibit fullscreen, class:^(FreeTube)$"
        "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
        "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(zen)$"
        # Dim
        "dimaround, class:^(gcr-prompter)$"
        "dimaround, class:^(xdg-desktop-portal-gtk)$"
        "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
        # Disable floating for QEMU screens
        "tile, class:^(.qemu-system-x86_64-wrapped)$"
      ];

      "$mainMod" = "SUPER";

      "$opener" = "handlr launch";
      "$term" = "$opener x-scheme-handler/terminal --";

      # Vim-style homerow direction keys
      "$left" = "h";
      "$down" = "j";
      "$up" = "k";
      "$right" = "l";

      "$menu" = "fuzzel";

      "$scratchpad" = "${lib.getExe pkgs.scratchpad} -m '$menu --dmenu'";

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = lib.flatten [
        "$mainMod, Return, exec, $term"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, Q, exec, wlogout --show-binds"
        # Run in shell to ensure file manager sees environment variables
        # TODO: figure out how to un-hard-code shell
        # TODO: figure out how to open selected file when exiting without hard-coding xplr
        "$mainMod, N, exec, $term --class=filemanager -- $opener inode/directory"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, pkill $menu || $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, S, togglesplit, # dwindle"
        "$mainMod, D, exec, hyprctl keyword general:layout dwindle"
        "$mainMod, M, exec, hyprctl keyword general:layout master"
        "$mainMod, O, exec, $opener x-scheme-handler/https"
        "$mainMod, G, togglegroup"
        "$mainMod, F, fullscreen"
        "$mainMod, C, exec, ${lib.getExe pkgs.hyprpicker} --autocopy"
        "$mainMod SHIFT, G, lockactivegroup, toggle"
        "$mainMod, bracketleft, changegroupactive, b"
        "$mainMod, bracketright, changegroupactive, f"
        ", Print, exec, ${lib.getExe pkgs.custom.screenshot}"
        ", XF86AudioPlay, exec, playerctl play-pause"
        "CTRL ALT, delete, exec, hyprctl kill"
        "$mainMod, Z, exec, $scratchpad"
        "$mainMod SHIFT, Z, exec, $scratchpad -g"

        # hyprexpo
        "$mainMod ALT, grave, hyprexpo:expo, toggle"

        # Move focus with mainMod + direction keys
        # Move active window with mainMod + SHIFT + direction keys
        (builtins.map
          (
            key:
            let
              dir = (builtins.elemAt (lib.strings.stringToCharacters key) 1);
            in
            [
              "$mainMod, ${key}, movefocus, ${dir}"
              "$mainMod SHIFT, ${key}, movewindoworgroup, ${dir}"
            ]
          )
          [
            "$left"
            "$down"
            "$up"
            "$right"
          ]
        )

        # Switch workspaces with mainMod + [0-9]
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        (builtins.genList (
          x:
          let
            ws = x + 1;
            key = toString (lib.trivial.mod ws 10);
          in
          [
            "$mainMod, ${key}, workspace, ${toString ws}"
            "$mainMod SHIFT, ${key}, movetoworkspace, ${toString ws}"
          ]
        ) 10)

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      "$LMB" = "mouse:272";
      "$RMB" = "mouse:275";

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, $LMB, movewindow"
        "$mainMod, $RMB, resizewindow"
      ];

      cursor.inactive_timeout = 60;

      plugin = {
        hyprexpo = {
          bg_col = "$base";
          # Always start grid with first workspace
          workspace_method = "first 1";
        };
        hyprtrails.color = "$accent";
        hyprwinwrap.class = "hyprwinwrap";
      };
    };
    extraConfig = # hypr
      ''
        # Resize submap
        bind = $mainMod ALT, R, submap, resize
        submap = resize

        binde = , $right, resizeactive, 10 0
        binde = , $left, resizeactive, -10 0
        binde = , $up, resizeactive, 0 -10
        binde = , $down, resizeactive, 0 10

        bind = , escape, submap, reset
        submap = reset
      '';
  };

  xdg.configFile =
    let
      nixagoLib = inputs.nixago.lib.${pkgs.system};
    in
    {
      "hyprland-autoname-workspaces/config.toml".source =
        let
          palette =
            (lib.importJSON "${config.catppuccin.sources.palette}/palette.json")
            .${config.catppuccin.flavor}.colors;
        in
        (nixagoLib.make {
          data = {
            version = pkgs.hyprland-autoname-workspaces.version;

            # TODO: Investigate if it would be possible to use eww literals as a replacement for inline pango
            format = rec {
              # Deduplicate icons if enable.
              # A superscripted counter will be added.
              dedup = true;
              dedup_inactive_fullscreen = true; # dedup more
              # window delimiter
              delim = " ";

              # workspace formatter
              workspace = "${workspace_empty}:{delim}{clients}"; # {id}, {delim} and {clients} are supported
              workspace_empty = "{name}"; # {id}, {delim} and {clients} are supported
              # client formatter
              client = "{icon}";
              client_active = "<span color='${palette.green.hex}'>${client}</span>";
            };

            class = {
              "legcord" = "󰙯";
              "blueman-manager" = "";
              "DEFAULT" = "";
              "[Ff]irefox" = "";
              "filemanager" = "";
              "FreeTube" = "";
              "libreoffice" = "󰈙";
              "lutris" = "";
              # "Minecraft" = "󰍳";
              "org.keepassxc.KeePassXC" = "󰌋";
              # "org.prismlauncher.PrismLauncher" = "󰍳";
              "org.pwmt.zathura" = "";
              "org.wezfurlong.wezterm" = "";
              "pavucontrol" = "󰕾";
              # "Py[Ss]ol" = "󰣎";
              ".qemu-system-x86_64-wrapped" = "󰍺";
              "steam" = "󰓓";
              ".yubioath-flutter-wrapped_" = "󰌋";
            };

            initial_title_in_class."^$" = {
              "(?i)spotify.*" = "";
            };

            exclude = {
              "" = "^$"; # Hide XWayland windows that remain after closing
              "[Ss]team" = "(Friends List.*|^$)"; # will match all Steam window with null title (some popup)
              "hyprwinwrap" = ".*"; # Hide hyprwinwrap background
            };
          };
          output = "config.toml";
        }).configFile;

      # For screenshot.sh
      "swappy/config".source =
        let
          fonts = config.stylix.fonts;
        in
        (nixagoLib.make {
          data.Default = {
            save_dir = "$HOME/Pictures/Screenshots";
            text_size = fonts.sizes.applications;
            text_font = fonts.sansSerif.name;
          };
          output = "config";
          format = "ini";
        }).configFile;
    };
}
