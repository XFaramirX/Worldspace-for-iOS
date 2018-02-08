#!/bin/bash

# The version of Xcode you want to fetch the framework for.
# If you need a given version built for you let us know.
# Our CI Servers build for XCode 9.# by default.
XCODE_VERSION=$(xcodebuild -version | head -n 1 | tr -d '[:space:]')

# Configurable VIA Command line
while getopts "v:x:" opt; do
    case "$opt" in
    v)  ATTEST_FRAMEWORK_VERSION=$OPTARG
        ;;
    esac
done

if [ -z "$ATTEST_FRAMEWORK_VERSION" ]; then 
    echo "Must request a specific version of the Attest Library. (Current: -v 1.2.0)"
    exit 1
fi

#This directory has to match up with your Framework Search paths in XCode Build Configuration.
FRAMEWORK_DIR=./Framework/Release

#Ensure it exists and change to it.
mkdir -p $FRAMEWORK_DIR
pushd $FRAMEWORK_DIR

source ~/.bash_profile

#Fetch the library zip with our anonymous api key.
curl -H "X-JFrog-Art-Api: ${DEQUE_ANON_APIKEY}" \
	-O "https://agora.dequecloud.com/artifactory/AttestIOSFree/framework/$XCODE_VERSION/Attest.framework-$ATTEST_FRAMEWORK_VERSION.zip"

#Unzip whatever version was fetched
unzip Attest.*zip
