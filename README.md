# android-build-signed-script
Script for creating a signing build environment

## Disclaimer
This script only works for password-less keys (DO NOT SET A PASSWORD) *This is due to building inline, other steps are necessary for a password*

*Works with Android 12+*

## How to run
1. Download the script in your root build directory and run it

MikuUI

`wget https://raw.githubusercontent.com/Ksawlii-Android-Repos/android-build-signed-script/main/miku-create-signed-env.sh`

`chmod +x miku-create-signed-env.sh`

`./miku-create-signed-env.sh`

AOSP

`wget https://raw.githubusercontent.com/Ksawlii-Android-Repos/android-build-signed-script/main/aosp-create-signed-env.sh`

`chmod +x aosp-create-signed-env.sh`

`./aosp-create-signed-env.sh`

2. Enter info for certificate subject line and confirm

3. Hit enter to set no password for each certificate. **Cannot set a password to build inline with this method!**

### Prep device tree
In your device tree (or common device tree) add:

MikuUI

`-include vendor/miku-priv/keys/keys.mk`

AOSP

`-include vendor/aosp-priv/keys/keys.mk`

Build as usual!
