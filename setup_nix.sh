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
  ln -s ../sj-www-app/ www
fi

# Add the android platform for cordova
cordova platform add android

# Add plugins to cordova
cordova plugin add ../cordova-plugins/cordova-plugin-media --link

cordova plugin add org.apache.cordova.device
cordova plugin add org.apache.cordova.camera
cordova plugin add org.apache.cordova.media-capture
cordova plugin add org.apache.cordova.file
cordova plugin add org.apache.cordova.file-transfer
cordova plugin add org.apache.cordova.console
cordova plugin add de.neofonie.cordova.plugin.nativeaudio

# Import crosswalk tolls
export ANDROID_HOME=$(dirname $(dirname $(which android)))

rm -rf $SPOTJAMS_DIR/sj-mob-app/platforms/android/CordovaLib/*

CROSSWALK_DIR="$SPOTJAMS_DIR/$(basename $(find $SPOTJAMS_DIR -maxdepth 1 -name 'crosswalk-cordova-*-arm'))"
echo "CROSSWALK_DIR = $CROSSWALK_DIR"
cp -r $CROSSWALK_DIR/framework/* $SPOTJAMS_DIR/sj-mob-app/platforms/android/CordovaLib/
cp $CROSSWALK_DIR/VERSION $SPOTJAMS_DIR/sj-mob-app/platforms/android/

cd $SPOTJAMS_DIR/sj-mob-app/platforms/android/CordovaLib/

ant debug

rm $SPOTJAMS_DIR/sj-mob-app/platforms/android/build.xml

cd $SPOTJAMS_DIR/sj-mob-app/platforms/android
android update project --subprojects --path . --target "android-21"
cd $SPOTJAMS_DIR/sj-mob-app
cordova build android
