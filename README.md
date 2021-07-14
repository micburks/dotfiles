# dotfiles

#### clone

```bash
mkdir -p ~/.config
git clone git@github.com:micburks/dotfiles.git ~/.config/nixpkgs
```


#### nix

```bash
NIX_INSTALLER_NO_MODIFY_PROFILE=1 sh <(curl https://nixos.org/nix/install) --no-daemon --darwin-use-unencrypted-nix-store-volume
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
