
# copied and modified from https://github.com/hlissner/dotfiles/blob/master/modules/editors/emacs.nix

{ config, lib, pkgs, pkgs-unstable, emacs, ... }:

with lib;
let 
    cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs = {
    enable = mkEnableOption "emacs";

    default = mkEnableOption "emacs as the default editor";

    doom = rec {
      enable = mkOption {
          default = cfg.enable;
          type = types.bool;
      };
      repoUrl = mkOption { type = types.str; default = "https://github.com/hlissner/doom-emacs"; };
      configRepoUrl = mkOption { type = types.str; default = "https://github.com/hlissner/doom-emacs-private"; };
    };
  };

  config = mkIf cfg.enable {
    environment.variables = mkIf cfg.default {
      "EDITOR" = "emacs";
    };

    environment.systemPackages = with pkgs; with emacs; [
      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      # 29 + pgtk + native-comp
      ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [
        epkgs.vterm
      ]))

      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      (mkIf (config.programs.gnupg.agent.enable)
        pinentry_emacs)   # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [
        en en-computers en-science
      ]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang beancount
      beancount
      pkgs-unstable.fava  # HACK Momentarily broken on nixos-unstable
    ];

    environment.sessionVariables.PATH = [ "$HOME/.emacs.d/bin" ];

    # modules.shell.zsh.rcFiles = [ "${configDir}/emacs/aliases.zsh" ];

    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

    system.userActivationScripts = mkIf cfg.doom.enable {
      installDoomEmacs = with pkgs; ''
        if [ ! -d "$HOME/.emacs.d" ]; then
           ${git}/bin/git clone --depth=1 --single-branch "${cfg.doom.repoUrl}" "$HOME/.emacs.d"
           # ${git}/bin/git clone "${cfg.doom.configRepoUrl}" "$XDG_CONFIG_HOME/doom"
        fi
      '';
    };
  };
}
