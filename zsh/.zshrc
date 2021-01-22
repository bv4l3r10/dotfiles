# export TERM="xterm-256color"

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source KUBE PS1
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

# Customize to your needs ...
DISABLE_AUTO_UPDATE=false
DISABLE_UPDATE_PROMPT=true

# Change random MAC address
function change_mac() {
    local mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    sudo ifconfig en0 ether $mac
    sudo ifconfig en0 down
    sudo ifconfig en0 up
    echo "MAC address: $mac"
}

# Terraform alias in order to append the | landscape command prettier
alias terraform="_terraform"

function prompt_terraform() {
    if [[ -n *.tf(#qN) ]]; then
        WORKSPACE=$("terraform" workspace show 2> /dev/null) || return
        "$1_prompt_segment" "$0" "$2" "$DEFAULT_COLOR" "red" "tf:$WORKSPACE"
    fi
}

function _terraform() {
    "terraform" "$@"
    # if [[ "$@" =~ "plan" ]] || [[ "$@" =~ "apply" ]]; then
    #     "terraform" "$@" | landscape
    # else
    #     "terraform" "$@"
    # fi
}

# Find libxml2 location path
libxml2=$(brew info libxml2 | grep Cellar | sed -e 's/ (.*//')

# Find terraform location path
terraform=$(brew info terraform@0.11 | grep Cellar | sed -e 's/ (.*//')

# Locales
export LC_ALL=$LANG

# NVM_DIR
export NVM_DIR="$HOME/.nvm"

# PATH
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$HOME/.GIS-lm-build/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# TERRAFORM 0.11
export PATH="/usr/local/opt/terraform@0.11/bin:$PATH"

# C_INCLUDE_PATH
export C_INCLUDE_PATH="$libxml2/include/libxml2:$C_INCLUDE_PATH"

# DOCKER_EXTERNAL_IP
export DOCKER_EXTERNAL_IP=`ipconfig getifaddr en0`

[[ -s "/usr/local/opt/nvm/nvm.sh" ]] && . "/usr/local/opt/nvm/nvm.sh"
[[ -s "/usr/local/opt/nvm/etc/bash_completion" ]] && . "/usr/local/opt/nvm/etc/bash_completion"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# To enable shims and autocompletion add to your profile:
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# Enabling export plugin to automatically expose JAVA_HOME
eval "$(jenv enable-plugin export)"

# Since we are using it, unalias lm
if alias lm > /dev/null; then unalias lm; fi

# Terraform auto-complete
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C ${terraform}/bin/terraform terraform

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/bmv/dotfiles/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/bmv/dotfiles/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/bmv/dotfiles/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/bmv/dotfiles/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/bmv/dotfiles/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/bmv/dotfiles/node_modules/tabtab/.completions/slss.zsh


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bmv/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bmv/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bmv/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bmv/google-cloud-sdk/completion.zsh.inc'; fi
