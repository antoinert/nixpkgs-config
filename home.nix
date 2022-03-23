{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [ git obsidian ];

  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      eamodio.gitlens
      matklad.rust-analyzer
    ];
  };

  programs.git = {
    enable = true;
    userName = "Anton Rautio";
    userEmail = "anton.rautio@gmail.com";
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;

    extraConfig = ''
      Host github.com
        User git
        IdentityFile ~/.ssh/id_rsa

      Host gitlab.com
        User git
        IdentityFile ~/.ssh/id_rsa
    '';
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    dotDir = ".config/zsh";

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      nd = "nix develop -c zsh";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      # plugins = [ "git" "thefuck" ];
      theme = "af-magic";
    };
  };
}

