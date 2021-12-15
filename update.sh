#!/bin/bash
#
# Update.

DIR_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $DIR_PATH/sh_utils/utils.sh

# Variables
ZINIT_HOME="$HOME/.zinit"

main() {
  update_rust
  update_homebrew
  update_zinit
}

update_rust() {
  if ! check_cmd rustup; then
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

main "$@"