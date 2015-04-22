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

- [nodejs](https://nodejs.org/download/)
- npm (installed by `setup_nix.sh`)
- cordova (installed by `setup_nix.sh`)
- cordova plugman (installed by `setup_nix.sh`)


### Android

- [Android SDK](http://developer.android.com/sdk/index.html#Other)
- [Crosswalk](https://crosswalk-project.org/documentation/downloads.html)


Download and extract the above 2 packages into your `spotjams` folder

add the following to your `.bash_profile`

```
export PATH=${PATH}:/Development/adt-bundle/sdk/platform-tools:/Development/adt-bundle/sdk/tools
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
