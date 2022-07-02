{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core;
in {
  options.modules.core = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    nix-ld.enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  imports = [
    ./nix.nix
    ./xdg.nix
    ./ssh.nix
    ./boot.nix
    ./avahi.nix
    ./user.nix
    ./security.nix
  ];

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Berlin";
    location = {
      latitude = 48.16;
      longitude = 11.58;
    };

    environment.systemPackages = with pkgs; [
      git
      vim
      file
      wget
      tmux
      gnumake
      mkdirenv
      direnv
    ];

    environment.variables.EDITOR = "vim";

    programs.nix-ld.enable = cfg.nix-ld.enable;

    programs.bash.shellInit = ''
      opt_source() {
          [[ -f "$1" ]] && source "$1"
      }

      opt_source "$HOME/.profile"
      opt_source "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
    '';

    networking.extraHosts = ''
      192.168.0.100   media.seifuku.local radarr.seifuku.local sonarr.seifuku.local documents.seifuku.local
      127.0.0.1   sonarr.kimono.local
      ::1         sonarr.kimono.local
    '';

    networking.nameservers = [
        "192.168.0.100"
        
        # quad9
        "9.9.9.10"
        "149.112.112.10"
        "2620:fe::10"
        "2620:fe::fe:10"
    ];

    networking.resolvconf.enable = pkgs.lib.mkForce false;
    networking.dhcpcd.extraConfig = "nohook resolv.conf";
    networking.networkmanager.dns = "none";
    services.resolved.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = mkDefault "21.11"; # Did you read the comment?
  };
}
