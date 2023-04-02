export EDITOR="vi"
export PATH="$PATH:${$(find ~/.local/bin -maxdepth 1 -type d -printf %p:)%%:}"
ZDOTDIR=~/.config/zsh/
