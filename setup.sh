# install dependencies
brew install neovim fzf bat eza git-delta zoxide ripgrep fd

# update .gitconfig
echo "Extending Git config"
if grep -q "; git-delta" ~/.gitconfig; then
	echo "git-delta already set up"
else
	echo "; git-delta\n[include]\n\tpath = \"$(realpath ./gitconfig)\"" >> ~/.gitconfig;
fi

# update .zshrc
echo "Extending .zshrc"
if grep -q "# dotfile" ~/.zshrc; then
	echo ".zshrc already updated"
else
	echo "# dotfiles\nsource $(realpath ./zshrc.sh)" >> ~/.zshrc
fi

# install kitty themes
echo "Installing Kitty themes"
git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes

# set kitty.conf
echo "Installing kitty.conf"
if [ -f ~/.config/kitty/kitty.conf ]; then
	echo "kitty.conf already exists. Move it somewhere else and try again"
else
	cp ./kitty.conf ~/.config/kitty/kitty.conf
fi

