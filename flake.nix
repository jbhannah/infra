{
  description = "Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    _1password-shell-plugins.url = "github:1Password/shell-plugins";
    _1password-shell-plugins.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.tinkaton = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/nixos/tinkaton
          home-manager.nixosModules.home-manager
          ./home
        ];
      };

      darwinConfigurations."Miraidon" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/darwin/miraidon
          home-manager.darwinModules.home-manager
          ./home
          ./home/darwin.nix
        ];
      };
    };
}
