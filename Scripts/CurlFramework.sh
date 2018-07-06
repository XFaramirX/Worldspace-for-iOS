#!/bin/bash

# The version of Xcode you want to fetch the framework for.
# If you need a given version built for you let us know.
# Our CI Servers build for XCode 9.# by default.

#This directory has to match up with your Framework Search paths in XCode Build Configuration.
FRAMEWORK_DIR=./Framework/Release

#Ensure it exists and change to it.
mkdir -p $FRAMEWORK_DIR
pushd $FRAMEWORK_DIR

source ~/.bash_profile

if [[ -z "${DEQUE_ATTEST_XCODE_VERSION}" ]]; then
    XCODE_VERSION=$(xcodebuild -version | head -n 1 | tr -d '[:space:]')
else
    XCODE_VERSION=$DEQUE_ATTEST_XCODE_VERSION
fi

if [[ -z "${DEQUE_ATTEST_LIBRARY_NAME}" ]]; then
    LIBRARY="AttestIOSFree"
else
    LIBRARY=$DEQUE_ATTEST_LIBRARY_NAME
fi

ATTEST_FRAMEWORK_VERSION=${DEQUE_ATTEST_IOS_VERSION}

if [ -z "$ATTEST_FRAMEWORK_VERSION" ]; then
    echo "No Attest IOS Framework version set.  Please set the environment variable \${DEQUE_ATTEST_IOS_VERSION} in your Bash profile. A list of framework versions is available at https://www.github.com/dequelabs/Worldspace-for-iOS/releases"
    exit 1
fi

if [ -z "${DEQUE_ANON_APIKEY}" ]; then
    echo "No API key found to retrieve the Attest IOS Framework.  In your Bash profile, please set the environment variable \${DEQUE_ANON_APIKEY} to be the API key that you have been emailed. See https://www.github.com/dequelabs/Worldspace-for-iOS for more information."
    exit 1
fi

if [ $LIBRARY != "AttestIOSFree" ] && [ $LIBRARY != "Attest-iOS" ]; then
    echo "The only available options for the DEQUE_ATTEST_LIBRARY_NAME variable  are \"AttestIOSFree\" and \"Attest-iOS\". The current value for this variable is $LIBRARY."
    exit 1
fi

#Fetch the library zip with our anonymous api key.
curl -s -H "X-JFrog-Art-Api: ${DEQUE_ANON_APIKEY}" \
	-O "https://agora.dequecloud.com/artifactory/$LIBRARY/framework/$XCODE_VERSION/Attest.framework-$ATTEST_FRAMEWORK_VERSION.zip"

#Unzip whatever version was fetched
if unzip Attest.framework-$ATTEST_FRAMEWORK_VERSION.zip &> /dev/null; then
    echo "Attest Successfully Fetched"
else 
    echo "Attest Failed to Download"
    echo "\"$XCODE_VERSION\" should match one of the URIs below (Except the /)"
        curl -s -H "X-JFrog-Art-Api: ${DEQUE_ANON_APIKEY}" "https://agora.dequecloud.com/artifactory/api/storage/$LIBRARY/framework/"
    
    echo ""

    echo "If your extact Xcode version isn't available you can override this in your bash_profile."
    echo "For example for Xcode 9.3.1 a proper bash_profile entry would be"
    echo ""
    echo "export DEQUE_ATTEST_XCODE_VERSION=Xcode9.3"
    echo "" 

    echo "Also \"$ATTEST_FRAMEWORK_VERSION\" should be available in the list below." 
    echo "The following artifacts are available for $XCODE_VERSION"

    curl -s -H "X-JFrog-Art-Api: ${DEQUE_ANON_APIKEY}" "https://agora.dequecloud.com/artifactory/api/storage/$LIBRARY/framework/$XCODE_VERSION"
    echo ""
    
    echo "If you're having trouble accessing an Attest framework bundle for your Xcode Version please contact helpdesk@deque.com"
    exit 1
fi
