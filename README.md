# WorldSpace for iOS Developers - Demo Application
This application contains a series of simple ViewControllers that demonstrates the types of Accessibility Issues the WorldSpace for iOS Framework looks for when it does an analysis. This repository also serves as documentation on how to link to and build accessibility tests against an application. While being the easiest place to start, you are also welcome to grab the framework (see Fetching Framework) and build it against your own application directly. 

NOTE: The version of the framework you will fetch is functionally limited. You will get reports from every rule on the number of violations, but will only get debugging information for the Color Contrast rule. Contact a Deque representative if you're interested in licensing WorldSpace for iOS and gaining access to this information for the other rules.

WorldSpace for iOS Libarry 1.0 Branch: [![1.0 CirclCI](https://circleci.com/gh/dequelabs/AttestIOS/tree/1.0.svg?style=shield&circle-token=317c78a2f327205f252a20d18e71b84516e2c912)](https://circleci.com/gh/dequelabs/AttestIOS/tree/1.0)

Build Status for this Repository: [![CircleCI](https://circleci.com/gh/dequelabs/AttestIOSApp/tree/master.svg?style=shield&circle-token=43cf7b8bde9c08b12f88f9282983a3837bcd6522)](https://circleci.com/gh/dequelabs/AttestIOSApp/tree/master)

## Building with WorldSpace for iOS

WorldSpace for iOS is a Swift framework. Most of the features are also designed to work in Objective C. Link to it like you would any other framework.

### Fetching Framework

To make switching to new versions of the Framework and keep from pushing the library to VCS systems check out our framework fetch script.

[Curl WorldSpace Framework](https://github.com/dequelabs/AttestIOSApp/blob/master/Scripts/CurlFramework.sh)

## Unit Testing Examples

Unit testing with the WorldSpace for iOS Framework is easy! Check out the examples below.

[A simple Accessibility Test](https://github.com/dequelabs/AttestIOSApp/blob/master/AttestiOSAppTests/SimpleTest.swift)

[Ignore Specific Violations](https://github.com/dequelabs/AttestIOSApp/blob/master/AttestiOSAppTests/IgnoreViolations.swift)

[Custom Rules](https://github.com/dequelabs/AttestIOSApp/blob/master/AttestiOSAppTests/CustomRules.swift)

## UI Testing Examples

Coming soon!

## Test Using the Desktop Client
[Starting the WorldSpace Server](https://github.com/dequelabs/AttestIOSApp/blob/master/AttestiOSApp/AppDelegate.swift)

[Syncing Results with the WorldSpace Desktop Client](https://dequeuniversity.com/guide/attest-mobile/1.0/using/manual-testing/desktop/analyzing/)

## Known Issues

### Accessibility Inspector On
When testing on the simulator, if you don't attach the Accessibility Inspector to the simulated device, the AT layer may not initialize. Our rules are designed in such a way, where this won't cause false positives, but it will cause fewer reports than expected. 

XCode -> Open Developer Tool -> Accessibility Inspector

Attach it to your simulator.
