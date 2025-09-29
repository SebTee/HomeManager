{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "seb.tom.tee@gmail.com";
    userName = "SebTee";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}