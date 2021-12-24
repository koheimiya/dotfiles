# Set up editor
cd $HOME
mkdir -p .config
ln -s 
cp -r /editor/nvim $HOME/.config/nvim
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugUpdate +qall
