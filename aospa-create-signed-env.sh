#!/bin/bash

# Prompt the user for each part of the subject line
read -p "Enter country code 'US' (C): " country
read -p "Enter state or province name 'California' (ST): " state
read -p "Enter locality 'Los Angeles' (L): " locality
read -p "Enter organization name 'AOSPA' (O): " organization
read -p "Enter organizational unit 'AOSPA' (OU): " organizational_unit
read -p "Enter common name 'ParanoidAndroid' (CN): " common_name
read -p "Enter email address 'android@android.com' (emailAddress): " email

# Construct the subject line
subject="/C=${country}/ST=${state}/L=${locality}/O=${organization}/OU=${organizational_unit}/CN=${common_name}/emailAddress=${email}"

# Print the subject line
echo "Using Subject Line:"
echo "$subject"

# Prompt the user to verify if the subject line is correct
read -p "Is the subject line correct? (y/n): " confirmation

# Check the user's response
if [[ $confirmation != "y" && $confirmation != "Y" ]]; then
    echo "Exiting without changes."
    exit 1
fi
clear


# Create Key
echo "Press ENTER TWICE to skip password (about 10-15 enter hits total). Cannot use a password for inline signing!"
mkdir ~/.android-certs

for x in bluetooth media networkstack nfc platform releasekey sdk_sandbox shared testkey verifiedboot; do \
    ./development/tools/make_key ~/.android-certs/$x "$subject"; \
done


## Create vendor for keys
mkdir -p vendor/aospa-priv
mv ~/.android-certs vendor/aospa-priv/keys
echo "PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/aospa-priv/keys/releasekey" > vendor/aospa-priv/keys/keys.mk
cat <<EOF > vendor/aospa-priv/keys/BUILD.bazel
filegroup(
    name = "android_certificate_directory",
    srcs = glob([
        "*.pk8",
        "*.pem",
    ]),
    visibility = ["//visibility:public"],
)
EOF

echo "Done! Now build as usual. If builds aren't being signed, add '-include vendor/aospa-priv/keys/keys.mk' to your device mk file"
echo "Make copies of your vendor/aospa-priv folder as it contains your keys!"
sleep 1
