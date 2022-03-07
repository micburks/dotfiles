# dotfiles

#### clone

```bash
mkdir -p ~/.config
git clone git@github.com:micburks/dotfiles.git ~/.config/nixpkgs
```


#### nix

[Nix manual](https://nixos.org/manual/nix/unstable/installation/installing-binary.html#macos-installation-a-namesect-macos-installation-change-store-prefixaa-namesect-macos-installation-encrypted-volumeaa-namesect-macos-installation-symlinkaa-namesect-macos-installation-recommended-notesa)

[Good post](https://www.philipp.haussleiter.de/2020/04/fixing-nix-setup-on-macos-catalina/) about setting up an encrypted volume

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
nix-channel --update nixpkgs
nix-env -u '*'
```


#### home manager

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install
```

nix build --no-link <flake-uri>#homeConfigurations.mickey.activationPackage
"$(nix path-info <flake-uri>#homeConfigurations.mickey.activationPackage)"/activate

~/.config/nixpkgs
github:micburks/dotfiles




#### install

```bash
# email for global gitconfig
echo "brks.mck@gmail.com" > ~/.config/nixpkgs/.user-email
home-manager switch
```

home-manager switch --flake '<flake-uri>#mickey'
