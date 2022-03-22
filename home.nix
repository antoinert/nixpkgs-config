{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = [ pkgs.git ];

  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    # extensions = with pkgs.vscode-extensions; [
    #  vscodevim.vim
    # ];
  };

  programs.git = {
    enable = true;
    userName = "Anton Rautio";
    userEmail = "anton.rautio@gmail.com";
  };
}

