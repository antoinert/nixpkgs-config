{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [ 
    git
    obsidian
    ripgrep
    git-crypt
    pandoc
    yarn
    vale
    flyctl
    stripe-cli
    vale
    ffmpeg
    doxygen
  ];

  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      eamodio.gitlens
      matklad.rust-analyzer
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      jakebecker.elixir-ls
      hashicorp.terraform
      github.copilot
      elixir-lsp.vscode-elixir-ls
      phoenixframework.phoenix
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "markdowntable";
        publisher = "TakumiI";
        version = "0.10.4";
        sha256 = "rynWwTPsDQirKu1uhs7rHIglTay/4S1MA0M17Mdjtxw=";
      }
    ];
  };

  programs.git = {
    enable = true;
    userName = "Anton Rautio";
    userEmail = "anton.rautio@gmail.com";

    extraConfig = {
      github.user = "antoinert";
      push.autoSetupRemote = true;
    };
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;

    extraConfig = ''
      Host mmain
        Hostname 138.68.113.197
        User root
        IdentityFile ~/.ssh/meterverse_rsa

      Host mmaster
        Hostname 104.248.103.13
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

    profileExtra =
      ''
      source $HOME/.cargo/env
      . $HOME/.asdf/asdf.sh
      eval "$(/opt/homebrew/bin/brew shellenv)"
      $(/opt/homebrew/bin/brew shellenv)
      '';

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

