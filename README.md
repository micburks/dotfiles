# dotfiles

#### clone

```bash
mkdir -p ~/.config
git clone git@github.com:micburks/dotfiles.git ~/.config/nixpkgs
```


#### nix

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
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install
```


#### install

```bash
# email for global gitconfig
echo "brks.mck@gmail.com" > ~/.config/nixpkgs/.user-email
home-manager switch
```
