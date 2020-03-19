#!/bin/sh
cd ~/

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --no-completion --no-update-rc

# repo must have been cloned to ~/_dotfiles
ln -s ~/_dotfiles/_tmux.conf ~/.tmux.conf
ln -s ~/_dotfiles/_gitignore_global ~/.gitignore_global
ln -s ~/_dotfiles/_gitconfig ~/.gitconfig
ln -s ~/_dotfiles/_vimrc ~/.vimrc
ln -s ~/_dotfiles/_oh-my-zsh/custom/themes/agnoster.zsh-theme ~/.oh-my-zsh/custom/themes/agnoster.zsh-theme
ln -s ~/_dotfiles/_oh-my-zsh/custom/themes/jtbx.zsh-theme ~/.oh-my-zsh/custom/themes/jtbx.zsh-theme

# install vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone https://github.com/itchyny/lightline.vim
git clone https://github.com/w0rp/ale
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/sheerun/vim-polyglot
git clone https://github.com/tpope/vim-commentary
cd ~/
