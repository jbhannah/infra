{ ... }:
{
  home.shellAliases = {
    l = "ls -alh";
  };

  imports = [
    ./brew.nix
    ./git.nix
  ];
}
