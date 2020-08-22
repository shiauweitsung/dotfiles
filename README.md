# dotfiles
- dotfiles for macOS

## Installation
```console
./install.sh
```

## Post Install Setup 
- Set terminal font to one of the Nerd Fonts
- If `zsh` is installed by Homebrew, iTerm2 needs to set Custom Shell to `/usr/local/zsh` on startup
- [Option + Left/Right Arrow Keys to move cursor by word](http://tgmerritt.github.io/jekyll/update/2015/06/23/option-arrow-in-iterm2.html)
    - Keyboard Shortcut: `Option+Left Arrow`, `Option+Right Arrow`
    - Action: `Send Escape Sequence`
    - ESC+: `b` for backward, `f` for forward

## Optional Post Install Steps
- [VSCode - Launching from the command line](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line) to add `code` command to terminals
- `go get -u github.com/derekparker/delve/cmd/dlv`

## References
- [Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Nerd Fonts - Homebrew Fonts](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts)
- [Characters per line (CPL)](https://en.wikipedia.org/wiki/Characters_per_line)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

#### dotfiles
- [dt665m/dotfiles](https://github.com/dt665m/dotfiles)

#### Vim
- [lwhsu .vimrc](https://github.com/lwhsu/rc/blob/master/.vimrc)
- [amix/vimrc](https://github.com/amix/vimrc)
- [pellaeon/Dotfiles/vimrc](https://github.com/pellaeon/Dotfiles/blob/master/vimrc)