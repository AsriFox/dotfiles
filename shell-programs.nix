{ config, pkgs, ... }:
let catppuccin = with config.catppuccin; { inherit enable flavour; };
in {
  home.packages = with pkgs; [ rustup gcc nixfmt ];

  home.sessionVariables = {
    XCURSOR_SIZE = 24;
    QT_QPA_PLATFORM = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };

  programs.git = {
    enable = true;
    userName = "AsriFox";
    userEmail = "asrifox@yandex.ru";
  };

  programs.fish = {
    enable = true;
    inherit catppuccin;
    functions = {
      nvim = "~/.nix-profile/bin/nvim -u ~/.config/nvim/init.lua $argv";
      cat = "bat --paging never --style plain $argv";
      less = "bat --paging always $argv";
    };
  };

  programs.bat = {
    enable = true;
    inherit catppuccin;
    config = { pager = "${pkgs.less}/bin/less -FR"; };
  };

  programs.neovim.enable = true;

  programs.lazygit = {
    enable = true;
    catppuccin = with config.catppuccin; {
      inherit enable flavour;
      accent = "lavender";
    };
  };

  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    font.size = 12;
    shellIntegration.enableFishIntegration = true;
    inherit catppuccin;
    settings = {
      background_opacity = "0.75";
      shell = "fish";
      editor = "nvim";
      clipboard_max_size = "64";
    };
  };

  services.cliphist.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
    inherit catppuccin;
    settings = {
      format =
        "$username$hostname$directory$cmd_duration$line_break$python$character";
      right_format = "$git_branch$git_state$git_status";
      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };
      git_branch = {
        format = "[$branch]($style)";
        style = "surface2";
      };
      git_status = {
        format =
          "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "teal";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };
      git_state = {
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        style = "surface1";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      python = {
        format = "[$virtualenv]($style) ";
        style = "surface2";
      };
    };
  };
}

