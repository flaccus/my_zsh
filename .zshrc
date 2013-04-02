# Auto-load screen if not loaded and I am connecting from a remote
if [[ $STY = '' ]] && [[ ! -z "$SSH_CLIENT" ]] then screen -xR; fi

# setup some history stuff
HISTFILE=~/.zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

# help speed up completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# set up stuff for completion and prompt customization
autoload -U promptinit compinit colors
compinit
colors
promptinit

# variables and functions for prompt with git
GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
GIT_BRANCH_SUFFIX="%{$fg[blue]%})"
GIT_PROMPT_SUFFIX="%{$reset_color%} % "
GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
GIT_PROMPT_CLEAN=""
GIT_PROMPT_AHEAD="↑"
GIT_PROMPT_ADDED="+"
GIT_PROMPT_DELETED="-"
GIT_PROMPT_BEHIND="↓"
GIT_PROMPT_DIVERGED="↕"
GIT_PROMPT_UNTRACKED="†"
source ~/.zsh/bin/git.zsh

# speed up git command tab-completion
__git_files () { 
    _wanted files expl 'local files' _files     
}


# load some plugins
source ~/.zsh/plugins/vi-mode/vi-mode.plugin.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# load my old bash_aliases file
if [ -f ~/.bash_aliases ]; then
    \. ~/.bash_aliases
fi

# my super cool prompt (which needs more tweaking - an indication of host if on a remote server)
PROMPT='%{$fg_bold[blue]%}$(get_host) %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}'

# bundle exec-ing everything
[ -f ~/.bundler-exec.sh ] && source ~/.bundler-exec.sh

PATH=$PATH:/usr/local/mysql/bin/:$HOME/.rvm/bin # Add RVM to PATH for scripting


setopt PROMPT_SUBST AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt inc_append_history SHARE_HISTORY
