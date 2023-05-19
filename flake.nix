{
  description = "Home Manager configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, nixpkgs, ... }:
    let
      system = "x86_64-darwin";
      username = USERNAME;
      email = EMAIL;
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home.nix
          {
            home = {
              inherit username;
              homeDirectory = "/Users/${username}";
              stateVersion = "22.11";
            };
          }
        ];
      };
    };
}
