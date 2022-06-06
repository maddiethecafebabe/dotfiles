inputs: { host, extraModules ? [], server ? false,  system ? "x86_64-linux"}:
let
    inherit (inputs.nixpkgs.lib) nixosSystem lists optionalAttrs;
    inherit (inputs) grab-bag emacs-overlay home-manager;

    pubkeys = import ../hosts/pubkeys.nix;

    pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        };

    pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        };

    overlays.nixpkgs.overlays = lists.flatten [
        (import ../overlays)
        (import ../pkgs)
    ];
in nixosSystem {
    inherit system;

    modules = extraModules ++ [
        grab-bag.nixosModules.default
        home-manager.nixosModules.home-manager
        overlays
        ../modules
        ../hosts/${host}/configuration.nix
    ];

    specialArgs = {
        inherit inputs pubkeys pkgs-unstable emacs-overlay;
        emacs = emacs-overlay.packages."${system}";
    } // optionalAttrs (!server) { grab-bag = grab-bag.packages."${system}"; };
}
