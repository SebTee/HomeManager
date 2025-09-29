{ config, pkgs, ... }:

{
  home = {
    username = "seb";
    homeDirectory = "/home/seb";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      firefox
      vscode
      alacritty
      wofi
      gvfs
      nwg-look
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      gzip
      zip
      unzip
      gnutar
      pcmanfm
      file-roller
      waybar
    ];
    
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.gnome-themes-extra;
      name = "Adwaita";
      size = 22;
    };

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;
      ".config/waybar".source = ./waybar;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    sessionVariables = {
      EDITOR = "nano";
    };
  };
  
  # Allow Home Manager to manage fonts
  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;
}
