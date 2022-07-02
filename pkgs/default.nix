self: super: {
    mkdirenv = super.callPackage ./mkdirenv.nix {};
    fusee-nano = super.callPackage ./fusee-nano {};

    # macos libraries that it will bitch about me not providing even though
    # they arent used
    lapce-upstream = super.callPackage ./lapce-upstream.nix {
        libobjc = null;
        Security = null;
        CoreServices = null;
        ApplicationServices = null;
        Carbon = null;
        AppKit = null;
    };
}
