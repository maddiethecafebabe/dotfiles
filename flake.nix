{
  description = "The root of all weebness";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # yeah this is totally valid syntax, trust me
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }: with inputs.nixpkgs.lib; let overlays = {
    nixpkgs.overlays = lists.flatten [ (import ./overlays) ];
  }; 

  in {    
    nixosConfigurations = {
      "yukata" = nixosSystem {
        system = "x86_64-linux";

        modules = [
          overlays
          ./modules
          ./hosts/yukata/configuration.nix
          ./hosts/yukata/hardware-configuration.nix
        ];

        specialArgs = { inherit inputs; };
      };

    };
  };
}
