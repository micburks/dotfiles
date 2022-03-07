{
  description = "Home Manager configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, ... }:
    let
      system = "x86_64-darwin";
      username = USERNAME;
      email = EMAIL;
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home.nix;

        inherit system username;

        homeDirectory = "/Users/${username}";
        stateVersion = "21.11";
        extraSpecialArgs = {
          inherit email;
        };
      };
    };
}
