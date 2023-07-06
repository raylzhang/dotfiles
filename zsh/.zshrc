# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export PATH=$HOME/bin:/usr/local/bin:$PATH
# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
export ZSH="/Users/raylzhang/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 30

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias lls="ls --color -lAFht"
alias ll="ls --color -lAFht | less"
alias t="tree -a "
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias c="code"

alias gh='cd ~'
alias df='cd ~/.dotfiles'
alias ni='cd ~/.config/nvim/lua'
alias ob='cd ~/sft-ob/Ray'
alias vc='cd /Users/raylzhang/Library/Application\ Support/Code/User'
alias ri='cd /Users/raylzhang/Library/Rime'

# 清理.DS_Store文件
alias cleands='sudo find / -name ".DS_Store" -type f -exec rm -f {} \; -print 2>/dev/null'

# docker
alias dlogs='docker logs -tf --tail 200'

# 查看进程占用程序
alias pexe='lsof -a -d txt -Fn -p'

# 查找
alias rfind='sudo sh /Users/raylzhang/script/rfind.sh'

# 项目脚本
raysite='/Users/raylzhang/prj-ray/raylzhang-hexo'
alias dpray='python $raysite/deploy.py'

#### Manual Configuration Area ####

## p10k theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet # 关闭每次打开的提示

## brew
eval "$(/opt/homebrew/bin/brew shellenv)"

## lf
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lfcd\n'

## lazygit
# ctrl-u toggle lazygit
#bindkey -s '^g' 'lazygit\n'

## clash
# clashx pro
alias proxy="export https_proxy=http://127.0.0.1:50169 http_proxy=http://127.0.0.1:50169 all_proxy=socks5://127.0.0.1:50169;echo \"Set proxy successfully!\""
# clashx
#alias proxy="export https_proxy=http://127.0.0.1:7890;export http_proxy=http://127.0.0.1:7890;export all_proxy=socks5://127.0.0.1:7890;echo \"Set proxy successfully!\""
alias unproxy="unset https_proxy;unset http_proxy;unset all_proxy;echo \"Unset proxy successfully!\""
alias ipcn="curl myip.ipip.net"
alias ip="curl ip.sb"
unproxy

## java
alias jdk8="export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"
#alias jdk11="export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home"
alias jdk17="export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
alias jdk20="export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-20.jdk/Contents/Home"
# 默认版本
jdk8

## maven
export M2_HOME=/opt/homebrew/Cellar/maven/3.9.0/bin

## mysql
#export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

## tomcat
#export CATALINA_HOME="/usr/local/Cellar/tomcat@9/9.0.56_1/libexec/"

## docker
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

## node（使用nvm）
#export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
#alias node16="export PATH=/opt/homebrew/opt/node@16/bin:$PATH"
#alias node12="export PATH=/opt/homebrew/opt/node@12/bin:$PATH"
#node12

## nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

## alias for cnpm
alias cnpm="npm --registry=https://registry.npmmirror.com \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npmmirror.com/mirrors/node \
  --userconfig=$HOME/.cnpmrc"

## go
#export GOROOT="/usr/local/Cellar/go/1.17.5/libexec"
#export GOPATH="/Users/ray/tech-ws/go"
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#export GO111MODULE=on
#export GOPROXY=https://goproxy.cn,direct
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8

## flutter
#export PUB_HOSTED_URL=https://pub.flutter-io.cn
#export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
#export PATH="$PATH:/opt/homebrew/Caskroom/flutter/2.10.3/flutter/bin"
#export PATH="$PATH:/opt/homebrew/Caskroom/flutter/2.10.3/flutter/bin/cache/dart-sdk/bin"
#export PATH="$PATH:/opt/homebrew/Caskroom/flutter/2.10.3/flutter/.pub-cache/bin" 
#export NO_PROXY=localhost,127.0.0.1,::1

## python
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"

## rust
#export PATH="/Users/raylzhang/.cargo/bin:$PATH"

## idea
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

