{ config, pkgs, ... }:
let
  layout = [
    {
      label = "lock";
      action = "loginctl lock-session";
      keybind = "l";
    }
    {
      label = "logout";
      action = "hyprctl dispatch exit";
      keybind = "e";
    }
    {
      label = "shutdown";
      action = "systemctl poweroff -i";
      keybind = "s";
    }
    {
      label = "suspend";
      action = "systemctl suspend";
      keybind = "u";
    }
    {
      label = "reboot";
      action = "systemctl reboot";
      keybind = "r";
    }
  ];
in {
  programs.wlogout = {
    enable = true;
    inherit layout;
    style = with config.catppuccin.palette;
      ''
        * {
          background-image: none;
        }
        window {
          background-color: alpha(#${crust}, 0.9);
        }
        button {
          color: #${text};
          background-color: #${base};
          border-style: solid;
          border-width: 2px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }
        button:focus, button:active, button:hover {
          background-color: #${surface2};
          outline-style: none;
        }
      '' + (builtins.concatStringsSep "\n" (builtins.map (c: ''
        #${c.label} {
          background-image: image(url("${pkgs.wlogout.outPath}/share/wlogout/icons/${c.label}.png"));
        }
      '') layout));
  };
}
