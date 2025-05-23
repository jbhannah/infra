{ inputs, ... }:
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
      _1password_ssh_agent_sock = "${config.home.homeDirectory}/${
        if pkgs.stdenv.isDarwin then "Library/Group Containers/2BUA8C4S2C.com.1password/t" else ".1password"
      }/agent.sock";

      signing_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAnSncawa7Y3U7/ZUkqnXLrAgJ5mxNLLKOgM20+dsV+";
    in
    {
      imports = [
        inputs._1password-shell-plugins.hmModules.default
        ./aliases/default.nix
      ];

      home.stateVersion = "25.05";

      home.file = {
        ".colima/default/colima.yaml" = {
          source = ./dotfiles/.colima/default/colima.yaml;
        };

        ".config/git/allowed_signers" = {
          text = "jesse@jbhannah.net ${signing_key}";
        };

        ".config/powershell/Microsoft.PowerShell_profile.ps1" = {
          source = ./dotfiles/.config/powershell/Microsoft.PowerShell_profile.ps1;
        };

        ".docker/config.json" = {
          source = ./dotfiles/.docker/config.json;
        };
      };

      home.packages = with pkgs; [
        cascadia-code
        httpie
        nixd
        nixfmt-rfc-style
        rsync
        rustup
      ];

      home.activation.rustup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run ${pkgs.rustup}/bin/rustup toolchain install $VERBOSE_ARG stable
      '';

      home.sessionPath = [
        "$HOME/.cargo/bin"
      ];

      home.sessionVariables = {
        SSH_AUTH_SOCK = _1password_ssh_agent_sock;
      };

      programs._1password-shell-plugins = {
        enable = true;
        plugins = with pkgs; [
          gh
        ];
      };

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
          gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
          init.defaultBranch = "trunk";
          log.showSignature = true;
          merge.conflictStyle = "zdiff3";
          pull.rebase = true;
        };
      };

      programs.home-manager.enable = true;

      programs.neovim = {
        enable = true;
        coc.enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withPython3 = true;
      };

      programs.ripgrep.enable = true;
      programs.ripgrep-all.enable = true;

      programs.ssh = {
        enable = true;
        matchBlocks."*".identityAgent = ''"${_1password_ssh_agent_sock}"'';
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

      services.macos-remap-keys = {
        enable = true;
        keyboard = {
          Capslock = "Control";
        };
      };

      targets.darwin.defaults = {
        "com.microsoft.VSCode" = {
          "ApplePressAndHoldEnabled" = false;
        };
      };
    };
}
