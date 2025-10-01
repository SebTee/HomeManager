{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      wofi
      wofi-power-menu
    ];

    file = {
      ".config/wofi-power-menu.toml".source = ./wofi-power-menu.toml;
    };
  };
}