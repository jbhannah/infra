{ ... }:
{
  home.shellAliases = {
    l = "ls -alh";

    pbc = "pbcopy";
    pbp = "pbpaste";
  };

  imports = [
    ./brew.nix
    ./git.nix
  ];
}
