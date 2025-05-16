{
  description = "Infrastructure flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      nix.enable = false;

      environment.extraInit = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [];

      homebrew.enable = true;
      homebrew.caskArgs.appdir = "~/Applications";
      homebrew.casks = [
        {
          name = "1password";
          args.appdir = "/Applications";
        }
        "1password-cli"
        "arc"
        "visual-studio-code"
        "warp"
      ];

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Miraidon
    darwinConfigurations."Miraidon" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
