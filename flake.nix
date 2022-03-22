{
  description = "Home Manager configuration of antoinert";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, ... }:
    let
      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        system = args.system or "x86_64-linux";
        configuration = import ./home.nix;
        homeDirectory = "/home/anton";
        username = "anton";
      } // args);
    in {
      nixosModules.home = import ./home.nix;

      homeConfigurations.armlinux = mkHomeConfiguration {
        system = "aarch64-linux";
      };

      homeConfigurations.x86linux = mkHomeConfiguration {};

      inherit home-manager;
    };
}
