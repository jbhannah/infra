{
  description = "Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Miraidon
    darwinConfigurations."Miraidon" = nix-darwin.lib.darwinSystem {
      modules = [ ./modules/darwin.nix ];
      specialArgs = { inherit inputs; };
    };
  };
}
