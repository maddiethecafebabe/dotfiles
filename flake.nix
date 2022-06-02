{
  description = "The root of all weebness";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    unstable.url = "nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    emacs-overlay.url  = "github:nix-community/emacs-overlay";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grab-bag = {
      url = "github:maddiethecafebabe/nix-grab-bag";
      # url = "/mnt/Shared/Dev/nix-grab-bag";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, unstable, nixos-hardware, grab-bag, ... }: 

  with inputs.nixpkgs.lib;   
  let    
    # make a function for all this boilerplate
    mkSystem = args @ { host, extraModules ? [], server ? false,  system ? "x86_64-linux"}:
    let
      pubkeys = import ./pubkeys.nix;
      myOverlays = final: prev: {
        unstable = import inputs.unstable {
          inherit system;
          config.allowUnfree = true;
        };
        grab-bag = grab-bag.overlays.default final prev;
      };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      overlays.nixpkgs.overlays = lists.flatten [
        (myOverlays)
        (import ./overlays)
        (import ./pkgs)
      ];
    in nixosSystem {
        system = system;
        modules = extraModules ++ [
          grab-bag.nixosModules.default
          home-manager.nixosModules.home-manager
          overlays
          ./modules
          ./hosts/${host}/configuration.nix
          # inputs.agenix.nixosModule
        ];

        specialArgs = {
          inherit inputs pubkeys;
        };
    }; 
  in {
    nixosModules = {
      # modules = (import ./modules);
    };

    nixosConfigurations = {
      yukata = mkSystem { host = "yukata"; };
      seifuku = mkSystem {
        host = "seifuku";
        server = true;
        extraModules = [ nixos-hardware.nixosModules.raspberry-pi-4 ];
        system = "aarch64-linux";
      };
      kimono = mkSystem { host = "kimono"; };
    };
  };
}
