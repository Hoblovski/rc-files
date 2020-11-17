# GENERIC SETTINGS
export ZSH="/home/hob/.oh-my-zsh"

ZSH_THEME="michelebologna"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source /etc/zsh_command_not_found
source /usr/share/autojump/autojump.sh
stty -ixon
unsetopt AUTO_CD
export EDITOR='vim'
export LANG=en_US.UTF-8
export HIST_STAMPS="mm/dd/yyyy"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export ZLE_RPROMPT_INDENT=0
bindkey '^[a' backward-word
bindkey '^[d' forward-word

cd() {
    builtin cd "$@"
    ls -F
}

alias grst="git checkout -- . && git clean -fdx && git submodule update --recursive"
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'

rsed() {
  find . -iname ${2:-*} -type f -exec sed -i $1 {} +
}

#==============================================================================
# PERMACHINE SETTINGS
export JAVA_HOME=/home/hob/Programs/utils/jdk

export PATH=''\
/home/hob/Programs/utils/node-v12.18.2-linux-x64/bin:\
$HOME/.local/bin:\
$HOME/Programs/utils/python-local/bin:\
$PATH:\
$HOME/.cargo/bin:\
$HOME/Programs/utils/riscv64-unknown-elf-gcc-8.3.0-2020.04.0-x86_64-linux-ubuntu14/bin/:\
$HOME/Programs/utils/riscv-prebuilt/bin:\
$HOME/Programs/utils/go-1.14/bin:\
/home/hob/Programs/prusti-dev/bin:\
/home/hob/Programs/utils/gradle-6.5.1/bin:\
/home/hob/Programs/utils/sbt/bin:\
/home/hob/Programs/thuctf20/sort/release/nanomips-linux-musl/2018.04-02/bin


export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:\
$HOME/Programs/utils/riscv-prebuilt/lib

#==============================================================================
# MIRRORS

# Rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
