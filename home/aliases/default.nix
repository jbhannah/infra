{ pkgs, ... }:
{
  home.shellAliases = {
    l = "ls -alh";
    cat = "${pkgs.bat.meta.mainProgram}";
  };

  imports = [
    ./git.nix
  ];
}
