{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.hypridle.homeManagerModules.hypridle
    inputs.hyprlock.homeManagerModules.hyprlock
  ];

  services.hypridle = {
    enable = true;
    lockCmd = "${pkgs.hyprlock.outPath}/bin/hyprlock";
    beforeSleepCmd = "${pkgs.hyprlock.outPath}/bin/hyprlock";
    listeners = [
      {
        timeout = 300;
        onTimeout = "loginctl lock-session";
      }
      {
        timeout = 600;
        onTimeout = "${pkgs.hyprland.outPath}/bin/hyprctl dispatch dpms off";
        onResume = "${pkgs.hyprland.outPath}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 1800;
        onTimeout = "systemctl suspend";
      }
    ];
  };

  programs.hyprlock = with config.catppuccin.palette; {
    enable = true;
    package = pkgs.hyprlock;
    backgrounds = [{
      path = "screenshot";
      blur_size = 4;
      blur_passes = 2;
    }];
    input-fields = [{
      monitor = "DP-1";
      size = {
        width = 210;
        height = 40;
      };
      outline_thickness = 2;
      outer_color = "0xff${lavender}";
      inner_color = "0xff${base}";
      font_color = "0xff${text}";
    }];
    labels = [{
      monitor = "DP-1";
      text = "$TIME";
      color = "0xff${text}";
      font_size = 36;
      font_family = "FiraCode Nerd Font";
    }];
  };
}
