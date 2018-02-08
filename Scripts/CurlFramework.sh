#!/bin/bash

#If it already exists, leave it alone
if [ -d "./Framework/Release/Attest.framework" ]; then
    exit 0
fi

#Change this to the version of the framework you want.
FRAMEWORK_VERSION=1.1.2

#The version of Xcode you want to fetch the framework for (Xcode9.0 or Xcode9.1)
#The Xcode9.0 framework build should work for 8.0 - 9.0.1. If you need another build post an issue.
XCODE_VERSION=Xcode9.1

#This directory has to match up with your Framework Search paths in XCode Build Configuration.
FRAMEWORK_DIR=./Framework/Release

#Change version number if specified
if [ "$1" == "-v" ]; then
    shift
    FRAMEWORK_VERSION=$1
fi

#Ensure it exists and change to it.
mkdir -p $FRAMEWORK_DIR
pushd $FRAMEWORK_DIR

source ~/.bash_profile

#Fetch the library zip with our anonymous api key.
curl -H "X-JFrog-Art-Api: ${DEQUE_ANON_APIKEY}" \
	-O "https://agora.dequecloud.com/artifactory/AttestIOSFree/framework/$XCODE_VERSION/Attest.framework-$FRAMEWORK_VERSION.zip"

#Unzip whatever version was fetched
unzip Attest.*zip
