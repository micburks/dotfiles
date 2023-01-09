# -------------------------------
#
# node
#
# -------------------------------
# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# next js
export NEXT_TELEMETRY_DISABLED=1

### nX          - run node using specific version (8/10/12/14)
alias n8='nvm exec 8 node'
alias n10='nvm exec 10 node'
alias n12='nvm exec 12 node'
alias n14='nvm exec 14 node'

### vn          - (v)irtual (n)ode - switch to compatible node/yarn versions
alias vn='virtualnode'
virtualnode () {
  if [[ $(node -p -e "require('./package.json').engines") ]]; then
    nodeengine_nodever=$(node -p -e "require('./package.json').engines.node")
    echo $nodeengine_nodever
    sanitized_nodever=$(echo $nodeengine_nodever | tr -d '\>\<\=' | cut -d' ' -f1)
    if [[ $sanitized_nodever ]]; then
      echo "Updating node from $(node -v) to $sanitized_nodever..."
      nvm use $sanitized_nodever
      #. ~/.nvm/nvm.sh use $sanitized_nodever
    fi  
    nodeengine_yarnver=$(node -p -e "require('./package.json').engines.yarn")
    sanitized_yarnver=$(echo $nodeengine_yarnver | tr -d '\>\<\=' | cut -d' ' -f1) 
    if [[ $sanitized_yarnver ]]; then
      echo "Updating yarn from $(yarn -v) to $sanitized_yarnver..."       
      #yvm install $sanitized_yarnver
      yvm use $sanitized_yarnver
      #. ~/.yvm/yvm.sh use $sanitized_yarnver
    fi      
  fi
}

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# yvm
export YVM_DIR=$HOME/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
