{ pkgs, inputs, ... }:
{
  programs.hyprlock =
    let
      transparent = "0x00000000";
      opacity = "0x85";
    in
    {
      enable = true;

      settings = {
        general = {
          grace = 2;
          # Fade out takes a bit too long
          no_fade_out = true;
        };

        background = [ { color = transparent; } ];

        input-field = [
          # Center circle
          {
            size = "380, 270";
            outline_thickness = 15;
            outer_color = "${opacity}$lavenderAlpha";
            inner_color = "$base";
            font_color = "$text";
            fade_on_empty = false;
            placeholder_text = "";
            hide_input = true;
            check_color = "${opacity}$blueAlpha";
            fail_color = "${opacity}$maroonAlpha";
            fail_text = "";
            capslock_color = "${opacity}$peachAlpha";
            numlock_color = "${opacity}$yellowAlpha";
            bothlock_color = "${opacity}$pinkAlpha";

            halign = "center";
            valign = "center";
            position = "0, 0";
          }
          # Password dots
          {
            size = "200, 50";
            outline_thickness = 0;
            outer_color = transparent;
            inner_color = transparent;
            font_color = "$text";
            placeholder_text = "";
            check_color = transparent;
            fail_color = transparent;
            capslock_color = transparent;
            numlock_color = transparent;
            bothlock_color = transparent;

            halign = "center";
            valign = "center";
            position = "0, -85";
          }
        ];

        label = [
          # Failure attempts
          {
            text = "$ATTEMPTS[]";
            color = "$maroon";
            font_size = 20;

            halign = "center";
            valign = "center";
            position = "0, 85";
          }
          # Time
          {
            text = "cmd[update:200] date +'%r'";
            color = "$text";
            font_size = 30;

            halign = "center";
            valign = "center";
            position = "0, 0";
          }
          # Date
          {
            text = "cmd[update:1000] date +'%a, %x'";
            color = "$text";
            font_size = 20;

            halign = "center";
            valign = "center";
            position = "0, -50";
          }
        ];
      };
    };

  # Screensaver config
  xdg.configFile."pipes-rs/config.toml".source =
    (inputs.nixago.lib.${pkgs.system}.make {
      data = {
        color_mode = "rgb"; # ansi, rgb or none
        rainbow = 1; # 0-255
        kinds = [
          "heavy"
          "light"
          "curved"
          "outline"
        ];
        num_pipes = 2;
      };
      output = "config.toml";
    }).configFile;
}
