self: super: {
    mkdirenv = super.callPackage ./mkdirenv.nix {};
    activate-linux = super.callPackage ./activate-linux {};
}
