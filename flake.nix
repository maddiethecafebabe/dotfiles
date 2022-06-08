{
  description = "My descent into madness.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grab-bag = {
      url = "/mnt/Shared/Dev/nix-grab-bag";
      # url = "github:maddiethecafebabe/nix-grab-bag";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixos-hardware, ... }: 
  let    
    mkSystem = (import ./lib/mkSystem.nix) inputs; 
  in {
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
