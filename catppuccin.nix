{ lib, config, inputs, ... }:
let
  # FIXME: merge this into Stonks3141/ctp-nix?
  palettes = {
    macchiato = {
      rosewater = "f4dbd6";
      flamingo = "f0c6c6";
      pink = "f5bde6";
      mauve = "c6a0f6";
      red = "ed8796";
      maroon = "ee99a0";
      peach = "f5a97f";
      yellow = "eed49f";
      green = "a6da95";
      teal = "8bd5ca";
      sky = "91d7e3";
      sapphire = "7dc4e4";
      blue = "8aadf4";
      lavender = "b7bdf8";

      text = "cad3f5";
      subtext1 = "b8c0e0";
      subtext0 = "a5adcb";

      overlay2 = "939ab7";
      overlay1 = "8087a2";
      overlay0 = "6e738d";

      surface2 = "5b6078";
      surface1 = "494d64";
      surface0 = "363a4f";

      base = "24273a";
      mantle = "1e2030";
      crust = "181926";
    };
  };
  catppuccin-qt5ct = builtins.fetchGit {
    url = "https://github.com/catppuccin/qt5ct";
    rev = "89ee948e72386b816c7dad72099855fb0d46d41e";
  };
  flavour = let fl = config.catppuccin.flavour;
  in with builtins;
  lib.toUpper (substring 0 1 fl) + (substring 1 ((stringLength fl) - 1) fl);
in with lib; {
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  options.catppuccin = with types; {
    enable = mkEnableOption "Catppuccin theme for use in home-manager";
    palette = mkOption { type = attrsOf str; };
  };

  config = mkIf config.catppuccin.enable {
    catppuccin.palette = palettes.${config.catppuccin.flavour};

    qt = {
      enable = true;
      platformTheme = "qtct";
    };
    xdg.configFile."qt5ct/colors/Catppuccin-${flavour}.conf".source =
      "${catppuccin-qt5ct}/themes/Catppuccin-${flavour}.conf";
    # TODO: qt5ct module?
    # xdg.configFile."qt5ct/qt5ct.conf".text = ''
    #   custom_palette=true
    #   color_scheme_path=/home/asrifox/.config/qt5ct/colors/Catppuccin-${flavour}.conf
    # '';
  };
}
