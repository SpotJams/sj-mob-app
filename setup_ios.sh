#!/bin/bash

# Set this veriable to the location of the spotjams directory ($HOME/spotjams by
# default)
SPOTJAMS_DIR=$HOME/spotjams

# Prepare the required platforms/ plugins/ and www/ directories
cd $SPOTJAMS_DIR/sj-mob-app

if [[ ! -d platforms/ ]]; then
  mkdir platforms/
fi

if [[ ! -d plugins/ ]]; then
  mkdir plugins/
fi

if [[ ! -d www/ ]]; then
  if [[ ! -d ../sj-www-app/ ]]; then
    echo "sj-www-app not found..."
    echo "check out the sj-www-app git repository into $SPOTJAMS_DIR"
    exit 2
  fi
  ln -s ../sj-www-app/www www

fi

# add bower dependencies for www code
if [[ ! -d www/vendor/bower_components ]]; then
  echo "adding bower deps"
  cd www/vendor
  bower update
  cd ../..
fi

# Add plugins to cordova
cordova plugin add ../cordova-plugins/cordova-plugin-media --link

cordova plugin add org.apache.cordova.device
cordova plugin add org.apache.cordova.camera
cordova plugin add org.apache.cordova.media-capture
cordova plugin add org.apache.cordova.file
cordova plugin add org.apache.cordova.file-transfer
cordova plugin add org.apache.cordova.console
cordova plugin add de.neofonie.cordova.plugin.nativeaudio

####  TODO  #####
#  http://stackoverflow.com/a/29873742/2366390


# Add the android platform for cordova
cordova platform add ios

# Create an Xcode project file
cordova prepare
