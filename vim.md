# Notes on VIM customization
basics copied from <https://statico.github.io/vim3.html>

## additional steps:
- install Pathogen https://github.com/tpope/vim-pathogen
- install Lightline: see https://vimawesome.com/plugin/lightline-vim
- install ALE: see https://vimawesome.com/plugin/ale
- install vim-gitgutter: see https://vimawesome.com/plugin/vim-gitgutter
- install vim-polyglot: see https://vimawesome.com/plugin/vim-polyglot
- install commentery: see https://vimawesome.com/plugin/commentary-vim

## "Setup Script" (Plugins only)
```
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone https://github.com/itchyny/lightline.vim
git clone https://github.com/w0rp/ale
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/sheerun/vim-polyglot
git clone https://github.com/tpope/vim-commentary

cd ~/
ln -s -dotfiles/_vimrc .vimrc
```
