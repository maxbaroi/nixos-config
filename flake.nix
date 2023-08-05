{
  description = "Test flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      devbox = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
	modules = [./nixos/configuration.nix];
      };
    };
  };
}