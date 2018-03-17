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
export DEQUE_ATTEST_IOS_VERSION="1.2.1"
```

Check out the list of releases for more information.

[Release List](https://github.com/dequelabs/Worldspace-for-iOS/releases)

To keep from pushing the library to VCS systems, check out our framework fetch script.

[Curl WorldSpace Framework](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/Scripts/CurlFramework.sh)

## Unit Testing Examples

Unit testing with the WorldSpace for iOS Framework is easy! Check out the examples below.

[A simple Accessibility Test](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/AttestiOSAppTests/SimpleTest.swift)

[Ignore Specific Violations](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/AttestiOSAppTests/IgnoreViolations.swift)

[Custom Rules](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/AttestiOSAppTests/CustomRules.swift)

## UI Instrumented Test Examples

[Starting the WorldSpace HTTP Server](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/AttestiOSApp/AppDelegate.swift)

[A simple Accessibility Test](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/AttestiOSAppUITests/SimpleUITest.swift)

[Ignore Specific Violations](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/AttestiOSAppUITests/IgnoreViolationsUITest.swift)

[Highlight Violations During Instrumented Tests](https://github.com/dequelabs/Worldspace-for-iOS/blob/Calabash_Support/AttestiOSAppUITests/DemoUITest.swift)

## Test Using the HTTP Server

After [starting the HTTP Server](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/AttestiOSApp/AppDelegate.swift), visit

[http://localhost:8080/report/analyze.html](http://localhost:8080/report/analyze.html) to view results!

## Test Using the Desktop Client
[Starting the WorldSpace Server](https://github.com/dequelabs/Worldspace-for-iOS/blob/master/AttestiOSApp/AppDelegate.swift)

[Syncing Results with the WorldSpace Desktop Client](https://dequeuniversity.com/guide/attest-mobile/1.0/using/manual-testing/desktop/analyzing/)

## Test Using Calabash
In XCode, build the "AttestiOSApp-cal" target for the simulator device that Calabash will use (iPhone 7 is default for Calabash).

Next, run Calabash as you normally would.  If it hangs the first time you run it, exit out of Calabash and try again.

[See an example of a Feature file using Attest here](https://github.com/dequelabs/Worldspace-for-iOS/blob/Calabash_Support/features/AttestExample.feature)

[See the Attest Calabash Step file here](https://github.com/dequelabs/Worldspace-for-iOS/blob/Calabash_Support/features/steps/Attest.rb)

## Known Issues

### Accessibility Inspector On
When testing on the simulator, if you don't attach the Accessibility Inspector to the simulated device, the AT layer may not initialize. Our rules are designed in such a way, where this won't cause false positives, but it will cause fewer reports than expected. 

XCode -> Open Developer Tool -> Accessibility Inspector

Attach it to your simulator.
