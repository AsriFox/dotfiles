{ config, pkgs, ... }:
let
  programs = {
    term = "kitty";
    files = "dolphin";
    web = "firefox";
    polkit =
      "${pkgs.polkit-kde-agent.outPath}/libexec/polkit-kde-authentication-agent-1";
    wallpaper = "hyprpaper";
    # bar = "waybar";
    screenshot = rec {
      cmd = "hyprshot";
      window = "${cmd} -m window";
      monitor = "${cmd} -m output";
      region = "${cmd} -m region";
    };
  };
  workspaces = rec {
    DP-1 = [ "1" "2" "3" "4" "5" "6" ];
    DP-2 = [ "7" "8" "9" ];
    all = DP-1 ++ DP-2;
  };
  wallpapers =
    let wallpapersDir = "${config.home.homeDirectory}/Pictures/wallpapers";
    in {
      DP-1 = "${wallpapersDir}/kawakami_rokkaku_holo_bed_brush0.jpg";
      DP-2 = "${wallpapersDir}/1372775.png";
    };
in {
  home.packages = with pkgs; [ hyprpaper hyprshot ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [ "QT_QPA_PLATFORMTHEME,qt5ct" ];
      monitor = [
        "DP-1, preferred, 0x0, 1"
        "DP-2, preferred, 2560x480, 1"
        ", preferred, auto, 1"
      ];
      workspace = [ ]
        ++ (builtins.map (n: "${n}, monitor:DP-1") workspaces.DP-1)
        ++ (builtins.map (n: "${n}, monitor:DP-2") workspaces.DP-2);
      windowrule = [ "float, ^(.*polkit.*)$" ];
      windowrulev2 = [
        "idleinhibit fullscreen, class:(.+)"
        "float, class:(firefox), title:(Picture-in-Picture)"
        "dimaround, class:^(jetbrains-*)$"
      ];

      exec-once = with programs; [
        polkit
        wallpaper
        # bar
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      input = {
        kb_layout = "us,ru(typewriter)";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
      };

      general = with config.catppuccin.palette; {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "0xff${flamingo} 0xff${lavender} 45deg";
        "col.inactive_border" = "0xaa${surface0}";
        layout = "dwindle";
      };

      decoration = with config.catppuccin.palette; {
        rounding = 4;

        blur = {
          enabled = true;
          size = 4;
          passes = 2;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "0xee${surface0}";
      };

      animations = {
        enabled = "yes";
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
        pseudotile = "yes";
        preserve_split = "yes";
      };

      "$super" = "SUPER";
      bind = with programs;
        [
          "$super, Q, killactive,"
          "$super, P, togglefloating,"
          "$super SHIFT, P, pseudo,"
          "$super, J, togglesplit,"

          "$super, left, movefocus, l"
          "$super, right, movefocus, r"
          "$super, up, movefocus, u"
          "$super, down, movefocus, d"

          "$super CTRL, left, swapwindow, l"
          "$super CTRL, right, swapwindow, r"
          "$super CTRL, up, swapwindow, u"
          "$super CTRL, down, swapwindow, d"

          "$super, T, exec, ${term}"
          "$super, E, exec, ${files}"
          "$super, B, exec, ${web}"

          ", Print, exec, ${screenshot.region}"
          "ALT, Print, exec, ${screenshot.window}"
          "SHIFT, Print, exec, ${screenshot.monitor}"
        ] ++ map (n: "$super, ${n}, workspace, ${n}") workspaces.all
        ++ map (n: "$super SHIFT, ${n}, movetoworkspace, ${n}") workspaces.all;

      bindm =
        [ "$super, mouse:272, movewindow" "$super, mouse:273, resizewindow" ];
    };
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpapers.DP-1}
    preload = ${wallpapers.DP-2}

    wallpaper = DP-1, ${wallpapers.DP-1}
    wallpaper = DP-2, ${wallpapers.DP-2}
  '';
}
