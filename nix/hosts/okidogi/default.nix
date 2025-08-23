{ ... }:
{
  imports = [
    ../../.
    ../../modules/darwin.nix
  ];

  system.primaryUser = "bhannah";

  networking.hostName = "Okidogi";

  homebrew = {
    casks = [
      "ollama-app"
      "slack"
    ];
  };

  system.stateVersion = 6;
}
