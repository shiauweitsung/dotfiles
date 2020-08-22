#!/bin/bash

uninstallTools() {
	brew remove wget ffmpeg
}
uninstallTools

# Uninstall homebrew
uninstallHomebrew() {
	if ! which brew >/dev/null 2>&1; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
	fi
}
uninstallHomebrew


uninstallRust() {
	rustup self uninstall
}
uninstallRust