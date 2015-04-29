#!/bin/bash

# Set this veriable to the location of the spotjams directory, use full path
# since the script needs to be run as root (i.e. avoid using $HOME)
SPOTJAMS_DIR=$HOME/spotjams

# install xcode

# install homebrew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install node.js
brew install node

# install cordava and company
npm install -g cordova plugman ios-sim bower

echo "All dependencies installed successfully"

exit 0
