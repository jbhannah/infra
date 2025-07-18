{ config, ... }:
let
  brew = "${config.homebrew.brewPrefix}/brew";

  shellInit = ''
    eval "$(${brew} shellenv)"
  '';
in
{
  nix.enable = false;

  system.primaryUser = "brooklyn";

  users.users.${config.system.primaryUser} = {
    home = "/Users/${config.system.primaryUser}";
  };

  homebrew = {
    enable = true;

    brews = [
      {
        name = "colima";
        restart_service = "changed";
      }
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "lima-additional-guestagents"
      "mas"
    ];

    caskArgs.appdir = "~/Applications";
    casks = [
      {
        name = "1password";
        args.appdir = "/Applications";
      }
      "nordvpn"
      "the-unarchiver"
      "visual-studio-code"
    ];

    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "domt4/autoupdate"
    ];
  };

  programs.bash.interactiveShellInit = shellInit;

  programs.fish.shellInit = ''
    ${brew} shellenv | source
  '';

  programs.zsh.shellInit = shellInit;

  system.activationScripts.postActivation = {
    enable = true;
    text = ''
      sudo -u ${config.system.primaryUser} -i ${brew} autoupdate start --upgrade --immediate --cleanup --sudo || true
    '';
  };
}
