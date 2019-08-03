#!/bin/bash

COMMAND=$(cat <<EOF
(function(){
    var repl = require('repl');

    process.stdin.push('.load ${1}\n');

    repl.start({
        useGlobal:true,
        ignoreUndefined:true,
        prompt:'> '
    });
})();
EOF
)

node -e "${COMMAND}"
