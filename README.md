# dotfiles

#### requirements

- git
- github public key
- nix
- home-manager


#### clone

```bash
mkdir -p ~/.config
git clone git@github.com:micburks/dotfiles.git ~/.config/nixpkgs
```


#### install

```bash
# email for global gitconfig
echo "brks.mck@gmail.com" > ~/.config/nixpkgs/.user-email
home-manager switch
```
