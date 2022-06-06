self: super: {
    mkdirenv = super.callPackage ./mkdirenv.nix {};
    fusee-nano = super.callPackage ./fusee-nano {};
}
