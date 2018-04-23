# WorldSpace for iOS Developers - Demo Application
This application contains a series of simple ViewControllers that demonstrates the types of Accessibility Issues the WorldSpace for iOS Framework looks for when it does an analysis. This repository also serves as documentation on how to link to and build accessibility tests against an application. While being the easiest place to start, you are also welcome to grab the framework (see Fetching Framework) and build it against your own application directly. 

NOTE: The version of the framework you will fetch is functionally limited. You will get reports from every rule on the number of violations, but will only get debugging information for the Color Contrast rule. Contact a Deque representative if you're interested in licensing WorldSpace for iOS and gaining access to this information for the other rules.

Build Status for this Repository: [![CircleCI](https://circleci.com/gh/dequelabs/Worldspace-for-iOS.svg?style=svg&circle-token=8a49ac2e2745bcbe633fa7e2b69bf5844d677bbf)](https://circleci.com/gh/dequelabs/Worldspace-for-iOS)

## Building with WorldSpace for iOS

WorldSpace for iOS is a Swift framework. Most of the features are also designed to work in Objective C. Link to it like you would any other framework.

### Sign Up for Free Trial

An API key is required in order to access the framework.  If you have not already, sign up for a [free trial](https://accessibility.deque.com/ios-accessibility-testing-free-trial) to receive this key, which will be emailed to you.

### Fetching Framework

Once you have your API key, export it as an environment variable into .bash_profile:

```bash
export DEQUE_ANON_APIKEY=EMAILED_API_KEY
```

Also add an environment variable into your .bash_profile with the version of the framework that you would like to fetch:

```bash
export DEQUE_ATTEST_IOS_VERSION="1.2.2"
```

Check out the list of releases for more information.

[Release List](https://github.com/dequelabs/Worldspace-for-iOS/releases)

To keep from pushing the library to VCS systems, check out our framework fetch script.

[Curl WorldSpace Framework](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/Scripts/CurlFramework.sh)

## Testing with WorldSpace for iOS

For more information on testing, please visit our [Wiki](https://github.com/dequelabs/Worldspace-for-iOS/wiki)!

## Known Issues

### Accessibility Inspector On
When testing on the simulator, if you don't attach the Accessibility Inspector to the simulated device, the AT layer may not initialize. Our rules are designed in such a way, where this won't cause false positives, but it will cause fewer reports than expected. 

XCode -> Open Developer Tool -> Accessibility Inspector

Attach it to your simulator.
