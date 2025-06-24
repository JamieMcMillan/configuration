# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
# zstyle ':omz:update' frequency 13

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi


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
alias cat='bat --theme=OneHalfDark'
alias launchEC2="aws ssm start-session --profile default --target i-05864a83e260c5a4d --document-name AWS-StartPortForwardingSessionToRemoteHost  --parameters '{\"portNumber\":[\"22\"],\"localPortNumber\":[\"2223\"]}' --region eu-west-2"
alias launchMODTRAN="aws ssm start-session --profile default --target i-0b5759edad60b1e9d --document-name AWS-StartPortForwardingSessionToRemoteHost  --parameters '{\"portNumber\":[\"22\"],\"localPortNumber\":[\"2222\"]}' --region eu-west-2"
alias launchQADatabase="AWS_PROFILE=\"default\" aws ssm start-session --target i-0d9e1d81814e681fa --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{\"host\":[\"imageprocessingpipeline-databaseinstanceaa8a5fde-mc7mhgpczgaj.cbvsd0mwkfyb.eu-west-2.rds.amazonaws.com\"],\"portNumber\":[\"5432\"],\"localPortNumber\":[\"5446\"]}'"
alias launchProdDatabase="AWS_PROFILE=\"prod\" aws ssm start-session --target i-0de9c20373306d5b9 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{\"host\":[\"imageprocessingpipeline-databaseinstanceaa8a5fde-stb8dillkmgj.cuxrrn5lqzle.eu-west-2.rds.amazonaws.com\"],\"portNumber\":[\"5432\"],\"localPortNumber\":[\"5446\"]}'"
alias launchJMQADatabase="aws ssm start-session --target i-0d9e1d81814e681fa --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{\"host\":[\"jamiemcmillanimageprocess-databaseinstanceaa8a5fde-9bn326rwc0c7.cbvsd0mwkfyb.eu-west-2.rds.amazonaws.com\"],\"portNumber\":[\"5432\"],\"localPortNumber\":[\"5446\"]}'"
alias plot='gnuplot plot.gnu'
alias prp='poetry run pytest'
alias pri='poetry run ipython'
alias svinfo="poetry run svinfo --qa --port 5446" 
alias svinfo-prod="AWS_PROFILE=prod poetry run svinfo --port 5446" 

# Add brew paths
eval "$(/opt/homebrew/bin/brew shellenv)"

# GPG key fix
export GPG_TTY=$(tty)

# Functions
# configuration git repository
# 	git is replaced by config
function config {
   /usr/bin/git --git-dir=$HOME/.configuration/ --work-tree=$HOME $@
}

# AWS default profile
export AWS_DEFAULT_PROFILE=default
# Poetry install bin
export PATH="/Users/jamiemcmillan/.local/bin:$PATH"

source $HOME/.profile
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Adding temporary ASP
export PATH="$PATH:/Users/jamiemcmillan/Documents/Development/StereoPipeline-3.5.0-alpha-2024-10-06-x86_64-OSX/bin"
export AMES_DIR="/Users/jamiemcmillan/Documents/Development/StereoPipeline-3.5.0-alpha-2024-10-06-x86_64-OSX/bin"

# GDAL speed up
export GDAL_DISABLE_READDIR_ON_OPEN=EMPTY_DIR

# Set FFMPEG EXE
export IMAGEIO_FFMPEG_EXE=/opt/homebrew/bin/ffmpeg

# Silence node.js warning
export JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION=1
