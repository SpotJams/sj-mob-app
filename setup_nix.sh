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
cordova platform add android

# Import crosswalk tolls
export ANDROID_HOME=$(dirname $(dirname $(which android)))
export ANDROID_BULID="ant"

rm -rf $SPOTJAMS_DIR/sj-mob-app/platforms/android/CordovaLib/*

CROSSWALK_DIR="$SPOTJAMS_DIR/$(basename $(find $SPOTJAMS_DIR -maxdepth 1 -name 'crosswalk-cordova-*-arm'))"
cp -r $CROSSWALK_DIR/framework/* $SPOTJAMS_DIR/sj-mob-app/platforms/android/CordovaLib/
cp $CROSSWALK_DIR/VERSION $SPOTJAMS_DIR/sj-mob-app/platforms/android/

sed -i -e 's/MainActivity/SpotJams/' $SPOTJAMS_DIR/sj-mob-app/platforms/android/build.xml
sed -i -e 's/MainActivity/SpotJams/' -e 's#</manifest>##' $SPOTJAMS_DIR/sj-mob-app/platforms/android/AndroidManifest.xml

# this fixes a permission issue that is missing in the default manifest file
# removes the ending t

# TODO  !!!  only do if "ACCESS_NETWORK_STATE" is not present in file

sed -i -e 's#</manifest>##' $SPOTJAMS_DIR/sj-mob-app/platforms/android/AndroidManifest.xml
(
  echo '    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />'
  echo '    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />'
  echo '</manifest>'
) >> $SPOTJAMS_DIR/sj-mob-app/platforms/android/AndroidManifest.xml

mv $SPOTJAMS_DIR/sj-mob-app/platforms/android/src/com/spotjams/app/MainActivity.java $SPOTJAMS_DIR/sj-mob-app/platforms/android/src/com/spotjams/app/SpotJams.java

sed -i -e 's/MainActivity/SpotJams/' $SPOTJAMS_DIR/sj-mob-app/platforms/android/src/com/spotjams/app/SpotJams.java

cd $SPOTJAMS_DIR/sj-mob-app/platforms/android/CordovaLib/

android update project --subprojects --path . --target "android-21"

ant debug

rm $SPOTJAMS_DIR/sj-mob-app/platforms/android/build.xml

cd $SPOTJAMS_DIR/sj-mob-app/platforms/android
cd $SPOTJAMS_DIR/sj-mob-app
cordova build android


