#!/usr/bin/env bash
set -e # This setting is telling the script to exit on a command error.
if [[ "$1" == "-v" ]]; then
    set -x # You refer to a noisy script.(Used to debugging)
fi

#http://yui.github.io/yuicompressor/
#cat test.js | java -jar ../bin/yuicompressor-2.4.8.jar --type=js > test.min.js

PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd $PWD



cat \
custom.js \
| java -jar ../../../bin/yuicompressor-2.4.8.jar --type=js > custom.min.js
# do-ajax.js \
