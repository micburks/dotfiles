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

        # See the changelog here:
        # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
        stateVersion = "21.11";

        # Optionally use extraSpecialArgs to pass through arguments to home.nix
      };
    };
}
