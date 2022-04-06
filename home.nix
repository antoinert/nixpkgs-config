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
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
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
      Host *
        IgnoreUnknown UseKeychain
        User git
        UseKeychain yes
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_rsa

      Host mmain
        Hostname 138.68.113.197
        User root
        IdentityFile ~/.ssh/meterverse_rsa

      Host github.com
        IgnoreUnknown UseKeychain
        User git
        UseKeychain yes
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_rsa

      Host gitlab.com
        IgnoreUnknown UseKeychain
        User git
        UseKeychain yes
        AddKeysToAgent yes
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

    profileExtra = "source $HOME/.cargo/env";

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    # zsh
    oh-my-zsh = {
      enable = true;
      plugins = [ "ssh-agent" ];
      theme = "af-magic";
    };
  };
}

