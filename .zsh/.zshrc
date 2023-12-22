source ~/.zsh/completion.zsh
source ~/.zsh/functions
# The following lines were added by compinstall
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.local/.zsh/cache
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename ~/.zshrc

autoload datetime
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob notify
bindkey -v

setopt hist_ignore_all_dups

if command -v less >/dev/null 2>&1
then
  export PAGER=less
else
  export PAGER=more
fi

if [ -f ~/.dircolors ]
then
  if command -v gdircolors >/dev/null 2>&1
  then
    eval $(gdircolors -b ~/.dircolors)
  elif command -v dircolors >/dev/null 2>&1
  then
    eval $(dircolors -b ~/.dircolors)
  else
    echo "No 'dircolors' or 'gdircolors' command found" >&2
  fi
else
  echo "No ~/.dircolors found, not setting" >&2
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
source ~/.zsh/aliases
source ~/.zsh/env
source ~/.zsh/prompt
source ~/.zsh/kaliases
BASE16_SCHEME="isotope"
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"
zstyle ':completion:*:*:git:*' user-commands co:'alias for checkout'
# [ -n "$PS1" ] && export PS1="%K{green}%n@%m%k %B%F{cyan}%(4~|...|)%3~%F{white} %# %b%f%k"
# if [ -e /Users/tv574p/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tv574p/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source ~/.zsh/submodules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if command -v direnv >/dev/null 2>&1
then
  eval "$(direnv hook zsh)"
fi
