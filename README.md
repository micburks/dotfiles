# Dotfiles

#### Clone

```bash
cd
mkdir -p ~/Code/oss && cd ~/Code/oss
git clone git@github.com:micburks/dotfiles.git
cd dotfiles
```

#### Install

```bash
mkdir -p ~/Code/oss
mkdir -p ~/Code/utilities
mkdir ~/scripts
mkdir ~/bin

# vim/bash
cd ~/Code/oss/dotfiles
cp .vimrc ~
cp .vim/bundle/install-plugins.bash ~/.vim/bundle/
cp .bash_profile ~
cp .gitignore ~
cp .gitconfig ~
cp .tmux.conf ~
cp .psqlrc ~
mkdir ~/scripts && cp -R scripts/ ~/scripts/
cd ~/.vim/bundle/ && ./install-plugins.bash

# git setup
git config --global core.excludesfile ~/.gitignore

# utilities

cd ~/Code/utilities
git clone git://github.com/wting/autojump.git
cd autojump
./install.py

cd ~/Downloads
wget https://ranger.github.io/ranger-stable.tar.gz
tar xvf ranger-stable.tar.gz
rm ranger-stable.tar.gz
mv $(ls | grep ranger) ~/bin/ranger

install-nvm
source ~/.bash_profile
nvm install node && nvm use default node
install-yarn
npm i -g vmd npx
```

TODO - make a script that copies everything to the right place

#### New mac checklist
- Fix dock, gestures, key repeat, color shift, settings for externals
- Chrome - log in to chrome and lastpass
- Spectacle
- Xcode tools (git, make)
- Generate new ssh key, upload to github and bitbucket
- vim pathogen
- Solarized dark color preset
- Patched fonts for Powerline: https://github.com/powerline/fonts
- VSCode
- Spotify
- Postgres.app, Aquameta
- Rearrange dock
- Clean ~/Downloads
- quicklisp, emacs et al, icons-in-terminal
- iTerm2-Color-Schemes
- sym link scripts

#### Chrome Web Dev profile extensions
- Veggie
- Browserstack loader
- EditThisCookie
- Lastpass
- Octotree
- Page ruler
- Postman interceptor
- React developer tools
- Redux devtools
- Resource override
- Vue.js devtools
