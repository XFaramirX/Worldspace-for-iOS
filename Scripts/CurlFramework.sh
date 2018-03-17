#!/bin/bash

# The version of Xcode you want to fetch the framework for.
# If you need a given version built for you let us know.
# Our CI Servers build for XCode 9.# by default.
XCODE_VERSION=$(xcodebuild -version | head -n 1 | tr -d '[:space:]')

#This directory has to match up with your Framework Search paths in XCode Build Configuration.
FRAMEWORK_DIR=./Framework/Release

#Ensure it exists and change to it.
mkdir -p $FRAMEWORK_DIR
pushd $FRAMEWORK_DIR

source ~/.bash_profile

ATTEST_FRAMEWORK_VERSION=${DEQUE_ATTEST_IOS_VERSION}

if [ -z "$ATTEST_FRAMEWORK_VERSION" ]; then
    echo "No Attest IOS Framework version set.  Please set the environment variable \${DEQUE_ATTEST_IOS_VERSION} in your Bash profile. A list of framework versions is available at https://www.github.com/dequelabs/Worldspace-for-iOS/releases"
    exit 1
fi

if [ -z "${DEQUE_ANON_APIKEY}" ]; then
    echo "No API key found to retrieve the Attest IOS Framework.  In your Bash profile, please set the environment variable \${DEQUE_ANON_APIKEY} to be the API key that you have been emailed. See https://www.github.com/dequelabs/Worldspace-for-iOS for more information."
    exit 1
fi

#Fetch the library zip with our anonymous api key.
curl -H "X-JFrog-Art-Api: ${DEQUE_ANON_APIKEY}" \
	-O "https://agora.dequecloud.com/artifactory/AttestIOSFree/framework/$XCODE_VERSION/Attest.framework-$ATTEST_FRAMEWORK_VERSION.zip"

#Unzip whatever version was fetched
unzip Attest.*zip
