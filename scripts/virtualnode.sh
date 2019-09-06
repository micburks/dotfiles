virtualnode () {
  if [[ $(node -p -e "require('./package.json').engines") ]]; then
    nodeengine_nodever=$(node -p -e "require('./package.json').engines.node")
    echo $nodeengine_nodever
    sanitized_nodever=$(echo $nodeengine_nodever | tr -d '\>\<\=' | cut -d' ' -f1)
    if [[ $sanitized_nodever ]]; then
      echo "Updating node to $sanitized_nodever..."
      nvm use $sanitized_nodever
    fi  
    nodeengine_yarnver=$(node -p -e "require('./package.json').engines.yarn")
    sanitized_yarnver=$(echo $nodeengine_yarnver | tr -d '\>\<\=' | cut -d' ' -f1) 
    if [[ $sanitized_yarnver ]]; then
      echo "Updating yarn to $sanitized_yarnver..."       
      yvm use $sanitized_yarnver
    fi      
  fi
}
