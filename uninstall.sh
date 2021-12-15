#!/bin/bash
#
# Uninstall.

DIR_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $DIR_PATH/sh_utils/utils.sh

main() {
  uninstall_tools
  uninstall_shell

  uninstall_languages
  uninstall_homebrew
}

uninstall_tools() {
  if check_os $OS_MAC; then
    brew remove kubectx hub shfmt
    brew remove tmux wget ffmpeg
  fi
}

uninstall_shell() {
  rm -rf ~/.zinit/
}

uninstall_languages() {
  if check_os $OS_MAC; then
    brew remove go
    brew remove node yarn

    brew remove --cask adoptopenjdk
  fi

  rustup self uninstall
}

uninstall_homebrew() {
  if ! check_os $OS_MAC; then
    return
  fi

  if check_cmd brew; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
  fi
}

main "$@"