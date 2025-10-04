{
  description = "Home Manager configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
  };

  outputs = { home-manager, nixpkgs, ... }:
    let
      system = "x86_64-darwin";
      username = USERNAME;
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home.nix
          {
            home = {
              inherit username;
              homeDirectory = "/Users/${username}";
              stateVersion = "23.05";
            };
          }
        ];
      };
    };
}
