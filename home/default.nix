{ ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.brooklyn =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      signing_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAnSncawa7Y3U7/ZUkqnXLrAgJ5mxNLLKOgM20+dsV+";
    in
    {
      imports = [
        ./aliases/default.nix
      ];

      home.stateVersion = "25.05";

      home.file = {
        ".config/git/allowed_signers" = {
          text = "jesse@jbhannah.net ${signing_key}";
        };

        ".config/nvim/init.lua" = {
          source = ./dotfiles/.config/nvim/init.lua;
        };

        ".config/nvim/lua" = {
          source = ./dotfiles/.config/nvim/lua;
        };
      };

      home.packages = with pkgs; [
        azure-cli
        fd
        fzf
        gcc
        gnumake
        httpie
        k9s
        kubectl
        kubernetes-helm
        nil
        nixd
        nixfmt-rfc-style
        tmux
      ];

      programs.bat.enable = true;

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.eza = {
        enable = true;
        extraOptions = [ "--group-directories-first" ];
        git = true;
      };

      programs.fish.enable = true;

      programs.git = {
        enable = true;
        lfs.enable = true;

        userEmail = "jesse@jbhannah.net";
        userName = "Jesse Brooklyn Hannah";

        signing = {
          key = signing_key;
          format = "ssh";
          signByDefault = true;
          signer = "ssh-keygen";
        };

        delta = {
          enable = true;

          options = {
            line-numbers = true;
            navigate = true;
            side-by-side = true;
          };
        };

        extraConfig = {
          fetch.prune = true;
          gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
          init.defaultBranch = "trunk";
          log.showSignature = true;
          merge.conflictStyle = "zdiff3";
          pull.rebase = true;
        };
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };

      programs.home-manager.enable = true;

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraPackages = with pkgs; [
          ast-grep
          imagemagick
          lazygit
          lua5_1
          luarocks
          lynx
          markdownlint-cli2
          nil
          shfmt
          stylua
          wget
        ];

        extraLuaPackages =
          ps: with ps; [
            tiktoken_core
          ];
      };

      programs.ripgrep.enable = true;
      programs.ripgrep-all.enable = true;

      programs.ssh = {
        enable = true;
        forwardAgent = true;
      };

      programs.starship.enable = true;

      programs.zsh = {
        enable = true;

        autocd = true;
        defaultKeymap = "viins";

        history = {
          append = true;
          extended = true;
          ignoreAllDups = true;
        };

        syntaxHighlighting = {
          enable = true;
        };
      };

      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        pinentry.package = lib.mkIf pkgs.stdenv.isDarwin pkgs.pinentry_mac;
      };
    };
}
