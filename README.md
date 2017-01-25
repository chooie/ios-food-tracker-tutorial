FoodTracker
===========
Playing with the FoodTracker app.

Made from the [ios tutorial](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/).

Trying out [Appium](http://appium.io/) too.

Notes
-----
- Build the iOS app:

        xcodebuild -project ios/FoodTracker.xcodeproj  -sdk iphoneos10.1

- Start the appium server:

        appium

- Run all the tests

        mvn -f ./appium clean test

  or some tests

        mvn -f ./appium -DFoodTracker.ios.<SomeTest>