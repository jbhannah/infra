{ pkgs, ... }:
{
  imports = [
    ../../.
    ../../modules/darwin.nix
  ];

  networking.hostName = "Miraidon";

  environment.systemPackages = with pkgs; [
    fish
    powershell
  ];

  environment.shells = with pkgs; [
    fish
    powershell
  ];

  homebrew = {
    taps = [
      "th-ch/youtube-music"
    ];

    brews = [
      {
        name = "syncthing";
        restart_service = "changed";
      }
      "imageoptim-cli"
    ];

    casks = [
      "alfred"
      "alt-tab"
      "balenaetcher"
      "brave-browser"
      "calibre"
      "chatgpt"
      "chrome-remote-desktop-host"
      "claude"
      "discord"
      "distroav"
      "firefox"
      "gcloud-cli"
      "ghostty"
      "google-drive"
      "imageoptim"
      "krita"
      "libndi"
      "melonds"
      "mgba-app"
      "microsoft-edge"
      "nordvpn"
      "notion"
      "notion-calendar"
      "notion-mail"
      "obs"
      "opera"
      "plex"
      "plexamp"
      "pokemon-tcg-live"
      "prismlauncher"
      "steam"
      "tailscale-app"
      "virtualbox"
      "vivaldi"
      "xquartz"
      "zed"
      "zen"

      "th-ch/youtube-music/youtube-music"
    ];

    masApps = {
      "1Password for Safari" = 1569813296;
      "Compressor" = 424390742;
      "Final Cut Pro" = 424389933;
      "Logic Pro" = 634148309;
      "Motion" = 434290957;
      "Pixelmator Pro" = 1289583905;
    };
  };

  programs.fish.enable = true;

  system.stateVersion = 6;
}
