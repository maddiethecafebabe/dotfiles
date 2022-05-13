{ pkgs, ... }:
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

    # Free up to 4GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (4 * 1024 * 1024 * 1024)}
    '';
  };
}
