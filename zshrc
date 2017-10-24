export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="spaceship"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(git stack)
source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# Launch emacs client automatically in daemon mode
alias ec='emacsclient --alternate-editor='''

# set proxy environment variables
function proxyon {
  local proxy='http://127.0.0.1:3128'
  export HTTP_PROXY="$proxy"
  export HTTPS_PROXY="$proxy"
  export http_proxy="$proxy"
  export https_proxy="$proxy"
}

# unset proxy environment variables
function proxyoff {
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset http_proxy
  unset https_proxy
}

# turn on cntlm
function cntlmon {
  cntlmps=$(pgrep cntlm)
  if [ -z "$cntlmps" ]; then
    echo "Starting CNTLM process..."
    cntlm -c ~/.config/cntlm/cntlm.conf
  else
    echo 'CNTLM is already running; not restarting'
  fi
  proxyon
}

# turn off cntlm
function cntlmoff {
  cntlmps=$(pgrep cntlm)
  if [ ! -z "$cntlmps" ]; then
    echo "Killing CNTLM process: $cntlmps"
    kill $cntlmps
  else
    echo 'CNTLM was not running'
  fi
  proxyoff
}