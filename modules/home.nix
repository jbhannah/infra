{ pkgs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.brooklyn = {
    home.stateVersion = "25.05";

    home.packages = with pkgs;
      [
        cascadia-code
        nixd
      ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.ssh = {
      enable = true;
      matchBlocks."*".identityAgent = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
    };
  };
}
