{ ... }:
{
  imports = [
    ../../.
    ../../modules/darwin.nix
  ];

  system.primaryUser = "bhannah";

  networking.computerName = "Okidogi";

  homebrew = {
    casks = [
      "ollama-app"
      "slack"
    ];
  };

  system.stateVersion = 6;
}
