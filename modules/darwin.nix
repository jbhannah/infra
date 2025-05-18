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
      "mas"
      "pinentry-mac"
    ];

    caskArgs.appdir = "~/Applications";
    casks = [
      {
        name = "1password";
        args.appdir = "/Applications";
      }
      "alfred"
      "arc"
      "chatgpt"
      "chrome-remote-desktop-host"
      "discord"
      "distroav"
      "google-chrome"
      "google-drive"
      "libndi"
      "notion"
      "nordvpn"
      "obs"
      "steam"
      "visual-studio-code"
      "warp"
    ];

    masApps = {
      "1Password for Safari" = 1569813296;
      "Compressor" = 424390742;
      "Final Cut Pro" = 424389933;
      "Logic Pro" = 634148309;
      "Motion" = 434290957;
      "Name Mangler 3" = 603637384;
      "Pixelmator Pro" = 1289583905;
      "Xcode" = 497799835;
      "Yoink" = 457622435;
    };

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
