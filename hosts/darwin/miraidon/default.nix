{
  config,
  inputs,
  pkgs,
  ...
}:
let
  brew = "/opt/homebrew/bin/brew";
  username = "brooklyn";

  shellInit = ''
    eval "$(${brew} shellenv)"
  '';
in
{
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.computerName = "Miraidon";
  system.primaryUser = username;

  environment.systemPackages = with pkgs; [
    fish
    powershell
  ];

  environment.shells = with pkgs; [
    fish
    powershell
  ];

  homebrew = {
    enable = true;

    taps = [
      "domt4/autoupdate"
      "th-ch/youtube-music"
    ];

    brews = [
      {
        name = "colima";
        restart_service = "changed";
        start_service = true;
      }
      "docker"
      "docker-compose"
      "docker-credential-helper"
      "imageoptim-cli"
      "mas"
    ];

    caskArgs.appdir = "~/Applications";
    casks = [
      {
        name = "1password";
        args.appdir = "/Applications";
      }
      "alfred"
      "alt-tab"
      "arc"
      "balenaetcher"
      "calibre"
      "chatgpt"
      "chrome-remote-desktop-host"
      "dash"
      "discord"
      "distroav"
      "firefox"
      "google-chrome"
      "google-drive"
      "httpie"
      "imageoptim"
      "krita"
      "libndi"
      "melonds"
      "mgba"
      "microsoft-edge"
      "nordvpn"
      "notion"
      "notion-calendar"
      "notion-mail"
      "obs"
      "opera"
      "pearcleaner"
      "plex"
      "plexamp"
      "pokemon-tcg-live"
      "prismlauncher"
      "steam"
      "visual-studio-code"
      "vivaldi"
      "warp"

      "th-ch/youtube-music/youtube-music"
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
      cleanup = "zap";
      upgrade = true;
    };
  };

  system.activationScripts.postActivation = {
    enable = true;
    text = ''
      sudo -u ${config.system.primaryUser} -i ${brew} autoupdate start --upgrade --immediate --cleanup --sudo || true
    '';
  };

  programs.fish.enable = true;
  programs.fish.shellInit = ''
    ${brew} shellenv | source
  '';

  programs.zsh.shellInit = shellInit;
  programs.bash.interactiveShellInit = shellInit;

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

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}
