{ inputs, ... }:
{
  home-manager.users.brooklyn =
    {
      config,
      pkgs,
      ...
    }:
    let
      _1password_ssh_agent_sock = "${config.home.homeDirectory}/${
        if pkgs.stdenv.isDarwin then "Library/Group Containers/2BUA8C4S2C.com.1password/t" else ".1password"
      }/agent.sock";
    in
    {
      imports = [
        inputs._1password-shell-plugins.hmModules.default
        ./aliases/darwin.nix
      ];

      home.packages = with pkgs; [
        cascadia-code
        rsync
      ];

      home.sessionVariables = {
        SSH_AUTH_SOCK = _1password_ssh_agent_sock;
      };

      programs._1password-shell-plugins = {
        enable = true;
        plugins = with pkgs; [
          gh
        ];
      };

      programs.ssh.matchBlocks."*".identityAgent = ''"${_1password_ssh_agent_sock}"'';

      services.macos-remap-keys = {
        enable = true;
        keyboard = {
          Capslock = "Control";
        };
      };

      targets.darwin.defaults = {
        "com.microsoft.VSCode" = {
          "ApplePressAndHoldEnabled" = false;
        };
      };
    };
}
