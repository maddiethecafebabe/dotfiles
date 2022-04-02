{
  description = "The root of all weebness";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixpkgs-unstable, ... }: 

  with inputs.nixpkgs.lib;   
  let 
    overlays = {
      nixpkgs.overlays = lists.flatten [ (import ./overlays) ];
    };

    user = { name = "maddie"; home = "/home/mads"; full_name = "Madeline"; }; 
    
    # make a function for all this boilerplate
    mkSystem = args @ { host, server ? false,  system ? "x86_64-linux"}: nixosSystem {
        system = system;
        modules = [
          overlays
          ./modules
          ./hosts/${host}/configuration.nix
        ] ++ optionals (!server) [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${user.name}" = import ./home/home.nix;

              home-manager.extraSpecialArgs = { user = user; };
            }
        ];

        specialArgs = {
          inherit inputs;
          user = user;
        };
    }; 
  in {    
    nixosConfigurations = {
      yukata = mkSystem { host = "yukata"; };
      seifuku = mkSystem { host = "seifuku"; server = true; system = "aarch64-linux"; };
      kimono = mkSystem { host = "kimono"; };
    };
  };
}
