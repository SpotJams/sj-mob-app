#!/bin/bash

# Set this veriable to the location of the spotjams directory, use full path
# since the script needs to be run as root (i.e. avoid using $HOME)
SPOTJAMS_DIR=/home/jbidness/spotjams

if [[ $EUID -ne 0 ]]; then
  echo "You must run this script as root!"
  exit 1
fi

# Install npm if it isn't already
if ! dpkg -s npm >/dev/null ; then
  apt-get install npm
else
  echo "npm found, skipping installation"
fi

# Install cordova (globally) if it isn't already
if ! npm ls -g cordova >/dev/null ; then
  npm install -g cordova
else
  echo "cordova found, skipping installation"
fi

# Install plugman (globally) if it isn't already
if ! npm ls -g plugman >/dev/null ; then
  npm install -g plugman
else
  echo "plugman found, skipping installation"
fi

echo "All dependencies installed successfully"
echo "Run 'android sdk' and install SDK version 19,21, and 22"
echo "before you continue and run setup_*.sh"
exit 0
