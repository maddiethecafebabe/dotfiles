{ pkgs, unstable, ... }:
let
  base = "/etc/nixpkgs/channels";
  nixpkgsPath = "${base}/nixpkgs";
in {
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  nix = {
    package = pkgs.nixUnstable;
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 21d";
    };

    nixPath = [
        "nixpkgs=${nixpkgsPath}"
        "/nix/var/nix/profiles/per-user/root/channels"
    ];

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    
  };

  systemd.tmpfiles.rules = [
      "L+ ${nixpkgsPath}     - - - - ${unstable}"
    ];
}
