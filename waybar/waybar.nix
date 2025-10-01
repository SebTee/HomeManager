{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.waybar ];
    file.".config/waybar".source = ./.;
  };
}