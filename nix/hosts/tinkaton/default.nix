{
  inputs,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ../../.
    ../../modules/nixos.nix
    ./hardware-configuration.nix
  ];

  _module.args.pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tinkaton";

  users.users.brooklyn.hashedPassword = "$6$iYeK2yG8GRpj0nhM$8ixeAMJFbzcu8BPI5YbLz75xmj/v2LvLBoviE8wlba31Ri..ldUTW.GJmy7NhashYT6CSOcO25LJr4s.fPPTr/";

  users.groups.media.gid = 20100;

  users.users.media = {
    uid = config.users.groups.media.gid;
    group = config.users.groups.media.name;
    isSystemUser = true;
  };

  fileSystems."/mnt/genesect/media" = {
    device = "genesect.home.local:/nfs/Media";
    fsType = "nfs";
    options = [
      "noatime"
      "nodiratime"
    ];
  };

  services.plex = {
    enable = true;
    openFirewall = true;
    package = pkgs-unstable.plex;
  };

  system.stateVersion = "25.05";
}
