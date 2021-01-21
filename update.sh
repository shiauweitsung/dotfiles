#!/bin/sh
#
# Update.

# Variables
ZINIT_HOME="$HOME/.zinit"

main() {
  update_rust
  update_homebrew
  update_zinit
}

update_rust() {
  if !check_cmd rustup; then
    info "No rust for update"
  fi

  info "Update rust"
  rustup update
}

update_homebrew() {
  if ! check_cmd brew; then
    info "No brew for update"
    return
  fi

  info "Update homebrew"
  # Update Homebrew
  brew update
  # Update packages
  brew upgrade
}

update_zinit() {
  if ! check_exist "${ZINIT_HOME}"; then
    info "No zinit for update"
    return
  fi

  info "Update zinit"
  zsh -ic 'zi self-update; zi update -p 20'
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

check_cmd() {
  command -v "$1" >/dev/null 2>&1
}

check_exist() {
  command ls "$1" >/dev/null 2>&1
}

main "$@"