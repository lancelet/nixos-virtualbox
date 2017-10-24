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