{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-gaming.url = "github:fufexan/nix-gaming";
 
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      suwface = lib.nixosSystem {
        specialArgs = {inherit inputs;};
	system = "x86_64-linux";
	modules = [
	  ./configuration.nix
	 inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
	 inputs.nix-gaming.nixosModules.pipewireLowLatency
	 inputs.home-manager.nixosModules.default
	];
      }; 
    };
  };
}
