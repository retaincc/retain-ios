### Status

[![Build Status](https://travis-ci.org/b123400/retain-ios.png)](https://travis-ci.org/b123400/retain-ios)

#Get started

1. Install CocoaPods with `gem install cocoapods`.

2. Edit your Podfile (Create one if you don't have), add this line:

    ```ruby
    pod 'RetainCC'
    ```
    
3. Run `pod install` in your XCode project directory.

4. Then import the library in AppDelegate

    ```objective-c
    #import <RetainCC/RetainCC.h>
    ```

5. Setup RetainCC after launch like this:

    ```objective-c    
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [RetainCC sharedInstanceWithApiKey:@"your api key" appID:@"your app id"];

    return YES;
}
    ```

#Logging Event

You can log event anywhere in your app like this:
```objective-c
[[RetainCC shared] logEventWithName:@"Clicked" properties:@{@"color":@"red"}];
```
