set fish_greeting ""

export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="/home/acer/bin/:$PATH"
export PATH="/home/acer/.config/suckless/dmenu/scripts/:$PATH"
export PATH="/home/acer/.config/suckless/dwm/scripts/:$PATH"
export PATH="/home/acer/.local/lib/python3.10/site-packages/:$PATH"
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'

# bind \co 'vi'

alias qt='cd ~/.config/qtile/'
alias config='/usr/bin/git --git-dir=$HOME/Stuff/DotFiles --work-tree=$HOME'
alias xm='cd ~/.xmonad/'
alias i3='cd ~/.config/i3/'
alias so='source $HOME/.config/fish/config.fish'
alias ls='exa -l -g --icons'
alias ll='ls --tree --level=1 -a'
alias gpsh='config push origin master'
alias gcmt='config commit'
alias gad='config add'
alias pkgs='pacman -Qq | wc -l'
alias plst='echo -n "Packages installed:- " ; pkgs'
# alias plst='pacman -Qq | fzf --preview "pacman -Qil {}" --bind "enter:execute(pacman -Qil {} | less)"'
# alias du=' du -sh'
alias batstatus='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias gcln='git clone'
alias mkdir='mkdir -p'
alias sync='sudo pacman -Sy'
alias tls='tmux ls'
alias update='sudo pacman -Syyu'
alias tmx='tmux -u attach || tmux'
alias install='sudo pacman -S'
# alias ftinst='flatpak install'
alias remove='sudo pacman -R'
alias rm='rm -r'
alias pclean='remove $(pacman -Qtdq)'
alias pinst='paru -S'
alias clean='sudo pacman -Sc'
# alias vi='nvim'
# alias find='sudo pacman -Ss'
# alias battery='notify-send $("acpi")'

function ex -a file
    if test -f "$file"
        switch "$file"
            case "*.tar.bz2"
                tar xjf $file
            case "*.tar.gz"
                tar xzf $file
            case "*.bz2"
                bunzip2 $file
            case "*.rar"
                unrar x $file
            case "*.gz"
                gunzip $file
            case "*.tar"
                tar xf $file
            case "*.tbz2"
                tar xjf $file
            case "*.tgz"
                tar xzf $file
            case "*.zip"
                unzip $file
            case "*.Z"
                uncompress $file
            case "*.7z"
                7z x $file
            case "*"
                echo "'$file' cannot be extracted via ex()"
        end
    else
        echo "'$file' is not a valid file"
    end
end

starship init fish | source
