{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  nixpkgs.config.allowUnfree = true;

  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  time.timeZone = "America/Los_Angeles";
}
