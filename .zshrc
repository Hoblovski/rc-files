# If there are still gaps at the right of term with this command,
#   it is because the terminal width is not a multiple of character width,
#   therefore character based terminal applications cannot use the gap at the right.
#   I current have no idea how to solve it.
ZLE_RPROMPT_INDENT=0

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hob/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="clean"
ZSH_THEME="michelebologna"
# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source /etc/zsh_command_not_found
source /usr/share/autojump/autojump.sh

# User configuration
stty -ixon
unsetopt AUTO_CD

# export MANPATH="/usr/local/man:$MANPATH"
export EDITOR='vim'
export LANG=en_US.UTF-8
HIST_STAMPS="mm/dd/yyyy"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZLE_RPROMPT_INDENT=0

export PATH=$PATH

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH

export LIBRARY_PATH=$LIBRARY_PATH

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias g++="g++ -std=c++11"
alias gcc="gcc -ansi -Wpedantic -std=c99"

# Personal settings
stty -ixon
export GOPATH=$HOME/go

export PATH=$PATH:$HOME/Downloads/riscv64-unknown-elf-gcc-2018.07.0-x86_64-linux-ubuntu14/bin:$HOME/Programs/utility/Typora-linux-x64/:/home/hob/Programs/riscv/bin:/home/hob/Programs/utility/z3-4.8.4.d6df51951f4c-x64-ubuntu-16.04/bin:/home/hob/Programs/utility/dafny
export PYTHONPATH=$PYTHONPATH:/home/hob/Programs/utility/z3-4.8.4.d6df51951f4c-x64-ubuntu-16.04/bin/python/
export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"
export LD_LIBRARY_PATH=/home/hob/Programs/utility/z3-4.8.4.d6df51951f4c-x64-ubuntu-16.04/bin

alias nogit="tmux setenv NOGIT 1"
alias yesgit="tmux setenv -u NOGIT"
#alias antlr4='java -jar /usr/local/lib/antlr-4.7.1-complete.jar'
#alias grun='java org.antlr.v4.gui.TestRig'
alias open="xdg-open"
alias grst="git checkout -- . && git clean -fdx && git submodule update --recursive"
hg() {
  history | rg "^\s*\d*\s*$1\b"
}
cd() {
	builtin cd "$@" && ls -F
}
fd() {
  local FN=`printf "%s*" $*`
  find . -iname "*$FN"
}
rsed() {
  find . -type f -exec sed -i $1 {} +
}

bindkey '^[a' backward-word
bindkey '^[d' forward-word



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export TERM=screen
