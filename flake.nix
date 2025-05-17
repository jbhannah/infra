{
  description = "Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    _1password-shell-plugins.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ nix-darwin, home-manager, ... }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Miraidon
      darwinConfigurations."Miraidon" = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/darwin.nix
          home-manager.darwinModules.home-manager
          ./modules/home.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
