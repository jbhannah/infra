{ inputs, ... }: {
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;

  environment.extraInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  environment.pathsToLink = [
    "/opt/homebrew/share/fish"
    "/opt/homebrew/share/zsh"
    "/usr/share/zsh"
  ];

  environment.systemPackages = [];

  homebrew = {
    enable = true;

    caskArgs.appdir = "~/Applications";
    casks = [
      {
        name = "1password";
        args.appdir = "/Applications";
      }
      "arc"
      "chatgpt"
      "discord"
      "google-chrome"
      "google-drive"
      "notion"
      "nordvpn"
      "visual-studio-code"
      "warp"
    ];

    onActivation.cleanup = "uninstall";
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.brooklyn = {
    name = "brooklyn";
    home = "/Users/brooklyn";
  };
}
