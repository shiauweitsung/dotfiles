#!/bin/bash

main() {
	uninstall_tools
	uninstall_shell

	uninstall_languages
	uninstall_homebrew
}

uninstall_tools() {
	brew remove kubectx hub shfmt
	brew remove tmux wget ffmpeg
}

uninstall_shell() {
	rm -rf ~/.zinit/
}

uninstall_languages() {
	brew remove go
	brew remove node yarn

	rustup self uninstall
}

uninstall_homebrew() {
	if ! which brew >/dev/null 2>&1; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
	fi
}

main "$@"