#!/bin/sh
#
# Install dotfiles.

main() {
  install_homebrew
  install_languages

  install_terminal
  install_shell
  install_vim
  install_editor
  install_tools

  setup_git
}

install_clt() {
  # Install Command Line Developer Tools for Xcode
  if check_cmd xcode-select; then
    xcode-select --install
  fi
}

install_homebrew() {
  if ! check_cmd brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
}

install_languages() {
  brew install go
  brew install node yarn

  # Install OpenJDK
  brew install --cask adoptopenjdk

  # Install Rust
  if ! check_cmd rustup; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source ~/.cargo/env
    rustup default stable

    # lints
    rustup component add clippy

    # Cross-compilation
    #rustup target add aarch64-apple-ios x86_64-apple-ios
    #rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android
  else
    rustup update
  fi
}

install_terminal() {
  brew install --cask iterm2
}

install_shell() {
  # Install zsh
  if ! check_cmd zsh; then
    brew install zsh zsh-completions
  fi
  # Set default shell to zsh
  chsh -s "$(which zsh)"

  # Merge zshrc contents if one already exists, otherwise just copy it over
  if [ -f ~/.zshrc ]; then
    info "Merging .zshrc files"
    cat zsh/.zshrc | cat - ~/.zshrc > temp && rm ~/.zshrc && mv temp ~/.zshrc
  else
    info "Copying .zshrc file"
    cp zsh/.zshrc ~/.zshrc
  fi

  # Install Nerdfonts
  #brew tap homebrew/cask-fonts
  #brew install --cask font-meslo-lg-nerd-font
  #brew install --cask font-fira-code-nerd-font
}

install_vim() {
  info "Copying .vimrc file"
  cp vim/.vimrc ~/.vimrc
}

install_editor() {
  brew install --cask visual-studio-code
  # Copy vscode settings
  mkdir -p ~/Library/Application\ Support/Code/User
  cp vscode/* ~/Library/Application\ Support/Code/User/
}

install_tools() {
  brew install kubectx hub shfmt
  brew install tmux wget ffmpeg
  # Copy tmux settings
  cp tmux/.tmux.conf ~/.tmux.conf
}

setup_git() {
  # Set git settings/aliases
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.com commit
  git config --global alias.st status
  git config --global credential.helper osxkeychain

  # if [ -z "$(git config --global --get user.email)" ]; then
  # 	echo "Git user.name:"
  # 	read -r user_name
  # 	echo "Git user.email:"
  # 	read -r user_email
  # 	git config --global user.name "$user_name"
  # 	git config --global user.email "$user_email"
  # fi
}

#
# Utils
#

# Colors
CLEAR='\033[2K'
NC='\033[0m'
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

info() {
  printf "\r  [ ${BLUE}..${NC} ] $1\n"
}

ok() {
  printf "\r${CLEAR}  [ ${GREEN}OK${NC} ] $1\n"
}

err() {
  printf "\r${CLEAR}  [ ${RED}ERR${NC} ] $1\n"
  exit
}

check_cmd() {
  command -v "$1" >/dev/null 2>&1
}

main "$@"