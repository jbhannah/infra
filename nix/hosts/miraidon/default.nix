{ pkgs, ... }:
{
  imports = [
    ../../.
    ../../modules/darwin.nix
  ];

  networking.computerName = "Miraidon";

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
      "imageoptim-cli"
    ];

    casks = [
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
      "notion"
      "notion-calendar"
      "notion-mail"
      "obs"
      "ollama"
      "opera"
      "pearcleaner"
      "plex"
      "plexamp"
      "pokemon-tcg-live"
      "prismlauncher"
      "stats"
      "steam"
      "vivaldi"
      "warp"
      "zed"

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
  };

  programs.fish.enable = true;

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

  system.stateVersion = 6;
}
