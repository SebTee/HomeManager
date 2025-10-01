{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    theme = "dracula_plus";
    settings = {
      window = {
        opacity = 0.8;
        blur = true;
      };
      font.normal.family = "JetBrainsMono Nerd Font Mono";
    };
  };
}