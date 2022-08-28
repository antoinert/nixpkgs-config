# nixpkgs-config
Nix home manager configurations for antoinert

## Apply home manager config
home-manager switch --impure --flake './#macos'

## Rebuild nixpkgs
nix build --impure --no-link './#homeConfigurations.macos.activationPackage'