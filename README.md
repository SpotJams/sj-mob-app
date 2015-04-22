SpotJams modile app
===================


# Installing Dependencies

The standard location to install the SpotJams dev codes is: `$HOME/spotjams`

clone all of the github repos into this directory

```
mkdir $HOME/spotjams
cd $HOME/spotjams

git clone git@github.com:verdverm/cordova-plugins
git clone git@github.com:verdverm/sj-www-app
git clone git@github.com:verdverm/sj-mob-app
```



### All Platforms

- [oracle java](http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html)
- [nodejs](https://nodejs.org/download/)
- npm
- cordova
- cordova plugman


### Android

- [Android SDK](http://developer.android.com/sdk/index.html#Other)
- [Crosswalk](https://crosswalk-project.org/documentation/downloads.html)


Download and extract the above 2 packages into your `spotjams` folder

add the following to your `.bash_profile`

```
export ANDROID_BIN=$HOME/spotjams/android-sdk-linux/tools:$HOME/spotjams/android-sdk-linux/platform-tools
export PATH=${PATH}:$ANDROID_BIN
```

Run the android sdk manager and add some stuff...
(defaults are probably fine)

Install SDK Tools / platform for APIs 19,21,22

```
android sdk

adb kill-server
adb start-server
```


Setting up cordova

#### install cordova

```
sudo npm install -g cordova plugman
```


#### Create project from current directory

[reference 1](https://crosswalk-project.org/documentation/cordova/migrate_an_application.html)

```
cd $HOME/spotjams/sj-mob-apprms

mkdir plugins platforms

cordova platform add android
```

```
cordova plugin add ../cordova-plugins/cordova-plugin-media --link

cordova plugin add org.apache.cordova.device
cordova plugin add org.apache.cordova.camera
cordova plugin add org.apache.cordova.media-capture
cordova plugin add org.apache.cordova.file
cordova plugin add org.apache.cordova.file-transfer
cordova plugin add org.apache.cordova.splashscreen
cordova plugin add org.apache.cordova.console
cordova plugin add de.neofonie.cordova.plugin.nativeaudio

```

#### Import the crosswalk tools

```
cd platforms/android/CordovaLib
rm -rf *
cp $HOME/spotjams/crosswalk-cordova-11.40.277.7-arm/framework/* $HOME/spotjams/sj-mob-app/platforms/android/CordovaLib

export ANDROID_HOME=$(dirname $(dirname $(which android)))
cd $HOME/spotjams/sj-mob-app/platforms/android
android update project --subprojects --path . --target "android-21"
cd ../..
cordova build android
```

#### link in the sj-www-app code

from the sj-mob-app directory
```
ln -s ../sj-www-app www
```



### iOS

- XCode
- cordova
- ios-sim

```
sudo npm install -g cordova plugman ios-sim
```


# Setup SpotJams dev environment

Run `setup_nix.sh`
