# dotfiles

#### clone

```bash
mkdir -p ~/.config
git clone git@github.com:micburks/dotfiles.git ~/.config/nixpkgs
```


#### nix

[Nix manual](https://nixos.org/manual/nix/unstable/installation/installing-binary.html#macos-installation-a-namesect-macos-installation-change-store-prefixaa-namesect-macos-installation-encrypted-volumeaa-namesect-macos-installation-symlinkaa-namesect-macos-installation-recommended-notesa)

(skip) [Good post](https://www.philipp.haussleiter.de/2020/04/fixing-nix-setup-on-macos-catalina/) about setting up an encrypted volume

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
nix-channel --update nixpkgs
nix-env -u '*'
```


#### build flake

TODO: Remove need for --impure
This would significantly decrease build time

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
# change USERNAME and EMAIL in flake.nix
nix build --no-link ~/.config/nixpkgs#homeConfigurations.$USER.activationPackage --impure
"$(nix path-info ~/.config/nixpkgs#homeConfigurations.$USER.activationPackage --impure)"/activate
home-manager switch --flake ~/.config/nixpkgs#$USER --impure
```
