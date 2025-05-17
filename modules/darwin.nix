{ inputs, ... }:
{
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.computerName = "Miraidon";
  system.primaryUser = "brooklyn";

  environment.extraInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  environment.pathsToLink = [
    "/opt/homebrew/share/fish"
    "/opt/homebrew/share/zsh"
    "/usr/share/zsh"
  ];

  environment.systemPackages = [ ];

  homebrew = {
    enable = true;

    taps = [
      "domt4/autoupdate"
    ];

    brews = [
      {
        name = "colima";
        restart_service = "changed";
        start_service = true;
      }
      "docker"
      "docker-compose"
      "pinentry-mac"
    ];

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

    onActivation = {
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  system.activationScripts.postActivation = {
    enable = true;
    text = ''
      sudo -u brooklyn -i /opt/homebrew/bin/brew autoupdate start --upgrade --immediate --cleanup --sudo || true
    '';
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

  users.users.brooklyn = {
    name = "brooklyn";
    home = "/Users/brooklyn";
  };
}
