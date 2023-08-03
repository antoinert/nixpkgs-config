{
  description = "Home Manager configuration of antoinert";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, nixpkgs, ... }:
    let
      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        pkgs = nixpkgs.legacyPackages.${"x86_64-linux"};
        modules = [
          ./home.nix
          {
            home = {
              username = "anton";
              homeDirectory = "/home/anton";
              stateVersion = "22.05";
            };
          }
        ];
        # system = args.system or "x86_64-linux";
        # configuration = import ./home.nix;
        # homeDirectory = "/home/anton";
        # username = "anton";
      } // args);
    in {
      nixosModules.home = import ./home.nix;

      homeConfigurations.armlinux = mkHomeConfiguration {
        system = "aarch64-linux";
      };

      homeConfigurations.x86linux = mkHomeConfiguration {};
      homeConfigurations.macos = mkHomeConfiguration {
        pkgs = nixpkgs.legacyPackages.${"aarch64-darwin"};
        modules = [
          ./home.nix
          {
            home = {
              username = "anton";
              homeDirectory = "/Users/anton";
              stateVersion = "22.05";
            };
          }
        ];
        # system = "aarch64-darwin";
        # homeDirectory = "/Users/anton";
      };

      inherit home-manager;
    };
}
