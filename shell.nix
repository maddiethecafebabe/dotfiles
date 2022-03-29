{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "dotfiles-bootstrap-shell";

  buildInputs = with pkgs; [
    git
    nixFlakes
  ];

  shellHook = ''
    alias nix="nix --option experimental-features 'nix-command flakes'"
  '';
}
