{
  description = "The root of all weebness";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    unstable.url = "nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, unstable, ... }: 

  with inputs.nixpkgs.lib;   
  let
    user = { name = "maddie"; home = "/home/mads"; full_name = "Madeline"; }; 
    
    # make a function for all this boilerplate
    mkSystem = args @ { host, server ? false,  system ? "x86_64-linux"}:
    let
      unstable-overlay = final: prev: {
        unstable = import inputs.unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      overlays = {
        nixpkgs.overlays = lists.flatten [ (unstable-overlay) (import ./overlays) (import ./pkgs) ];
      };
    in nixosSystem {
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

              home-manager.extraSpecialArgs = { 
                user = user;
                inherit inputs;
              };
            }
        ];

        specialArgs = {
          inherit inputs;
          unstable = inputs.unstable;
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
