#!/bin/bash

# Install homebrew
installHomebrew() {
	if ! which brew >/dev/null 2>&1; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}
installHomebrew

installTools() {
	brew install go
	brew install kubectx hub shfmt
	brew install wget ffmpeg
}
installTools

installRust() {
	# Install Rust
	if ! which rustup >/dev/null 2>&1; then
		curl https://sh.rustup.rs -sSf | sh -s -- -y
		source ~/.cargo/env
		rustup default stable
	else
		rustup update
	fi

	# Rust toolchains
	rustup component add clippy
	rustup target add aarch64-apple-ios x86_64-apple-ios
	rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android
}
installRust

# Install iTerm2 and VSCode
brew cask install iterm2
brew cask install visual-studio-code

# Install zsh
if ! which zsh >/dev/null 2>&1; then
	brew install zsh zsh-completions
	# Set default shell to zsh
	chsh -s "$(which zsh)"
	zsh --version
fi

# Merge zshrc contents if one already exists, otherwise just copy it over
if [ -f ~/.zshrc ]; then
	echo "=== Merging .zshrc Files (MIGHT REQUIRE MANUAL CLEANUP!) ==="
	cat zsh/.zshrc | cat - ~/.zshrc > temp && rm ~/.zshrc && mv temp ~/.zshrc
else
	echo "=== Copying .zshrc File ==="
	cp zsh/.zshrc ~/.zshrc
fi

# Install Zinit
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
#zinit self-update

installAntibody() {
	# Install Antibody
	brew install getantibody/tap/antibody
	cp zsh/.zsh_plugins.txt ~/.zsh_plugins.txt
	antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
	antibody update
}

installP9k() {
	# Install Powerlevel9k and Nerdfonts
	brew tap sambadevi/powerlevel9k
	brew install powerlevel9k
	brew tap homebrew/cask-fonts
	brew cask install font-meslo-lg-nerd-font
}

# Install Powerlevel10k
#brew tap romkatv/powerlevel10k
#brew install powerlevel10k

# Copy vim settings
cp vim/.vimrc ~/.vimrc

# Copy tmux settings
cp tmux/.tmux.conf ~/.tmux.conf

# Copy vscode settings
mkdir -p ~/Library/Application\ Support/Code/User
cp vscode/* ~/Library/Application\ Support/Code/User/

# Set git settings/aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.com commit
git config --global alias.st status
git config --global credential.helper 'cache --timeout 604800'
