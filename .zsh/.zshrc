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

if command -v mise >/dev/null 2>&1
then
  eval "$(mise activate zsh)"
else
  if command -v rbenv >/dev/null 2>&1
  then
    eval "$(rbenv init - zsh)"
  fi
fi

if command -v fzf >/dev/null 2>&1
then
  source <(fzf --zsh)
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search
