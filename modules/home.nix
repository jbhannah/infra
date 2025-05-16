{ pkgs, inputs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.brooklyn = {
    imports = [ inputs._1password-shell-plugins.hmModules.default ];

    home.stateVersion = "25.05";

    home.packages = with pkgs;
      [
        cascadia-code
        nixd
      ];

    programs._1password-shell-plugins = {
      enable = true;
      plugins = with pkgs;
        [
          gh
        ];
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.git = {
      enable = true;

      userEmail = "jesse@jbhannah.net";
      userName = "Jesse Brooklyn Hannah";

      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAnSncawa7Y3U7/ZUkqnXLrAgJ5mxNLLKOgM20+dsV+";
        format = "ssh";
        signByDefault = true;
        signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
    };

    programs.ssh = {
      enable = true;
      matchBlocks."*".identityAgent = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
    };

    programs.zsh.enable = true;
  };
}
