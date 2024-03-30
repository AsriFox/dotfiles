{
  description = "AsriFox's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:Stonks3141/ctp-nix";
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun-cliphist.url = "github:benoitlouy/anyrun-cliphist";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      username = "asrifox";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              # home-manager configuration
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "23.11";
              };
              xdg.enable = true;
              programs.home-manager.enable = true;
            }
            {
              imports = [ ./catppuccin.nix ];
              catppuccin = {
                enable = true;
                flavour = "macchiato";
              };
            }
            ./shell-programs.nix
            ./hyprland.nix
            ./hyprlock.nix
            ./wlogout.nix
          ];
          extraSpecialArgs = { inherit inputs; };
        };
    };
}
