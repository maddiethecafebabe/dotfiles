{ pkgs, inputs, ... }:
let
  base = "/etc/nixpkgs/channels";
  nixpkgsPath = "${base}/nixpkgs";
in {
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;

    settings = {
      auto-optimise-store = true;
      substituters = [ 
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 21d";
    };

    # this pins the nixpkgs channel thats used by e.g. nix-shell
    # to the unstable channel that the system flake uses. 
    # this is supposed to prevent non-installed applications from failing to
    # e.g. initialise opengl
    nixPath = [
        "nixpkgs=${nixpkgsPath}"
        "/nix/var/nix/profiles/per-user/root/channels"
    ];

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # belongs to the above pinning
  systemd.tmpfiles.rules = [
      "L+ ${nixpkgsPath}     - - - - ${inputs.nixpkgs-unstable}"
    ];
}
