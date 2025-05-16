{ pkgs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.brooklyn = {
    home.stateVersion = "25.05";

    home.packages = with pkgs;
      [
        cascadia-code
        direnv
        nixd
      ];
  };
}
