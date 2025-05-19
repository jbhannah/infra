{ ... }:
{
  home.shellAliases = {
    l = "ls -alh";
  };

  imports = [ ./git.nix ];
}
