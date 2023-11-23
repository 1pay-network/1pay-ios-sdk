<h1 align="center">
  <br>
  <a href="https://1pay.network" alt="1Pay.Network" width="200"><img src="https://1pay.network/assets/dist/imgs/logo.png" alt="1Pay.Network"></a>
  <br>
</h1>

# 1Pay.network iOS SDK

[![Version](https://img.shields.io/cocoapods/v/OnePaySDK.svg?style=flat)](https://cocoapods.org/pods/OnePaySDK)
[![License](https://img.shields.io/cocoapods/l/OnePaySDK.svg?style=flat)](https://cocoapods.org/pods/OnePaySDK)
[![Platform](https://img.shields.io/cocoapods/p/OnePaySDK.svg?style=flat)](https://cocoapods.org/pods/OnePaySDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 13+
* Swift 4.0+
* XCode 11+


## Installation

### CocoaPods
1Pay.network iOS SDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OnePaySDK'
```

Then run `pod install` command
```ruby
pod install
```

### Swift Package Manager
[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.
> Xcode 11+ is required to build OnePaySDK using Swift Package Manager.

To integrate OnePaySDK into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/1pay-network/1pay-ios-sdk.git", .upToNextMajor(from: "1.0.0"))
]
```
## Usage
### 1. Swift UIKit (UIViewController)
At `AppDelete.swift` file, add this line inside `didFinishLaunchingWithOptions` delegate
```swift
import OnePaySDK
...
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    ... // rest of implement
    
    OnePay.initialize(
        recipient: RECIPIENT_ADDRESS,
        supportedTokens: ["usdt","usdc","dai"],
        supportedNetworks: ["ethereum","arbitrum","optimism","bsc"])
        
    ...
    
    return true
}
...
```
After init, you can call `OnePay.pay` function whenever you want to process pay flow
```swift
OnePay.pay(self, // root view controller 
    amount: 0.1, // amount to pay
    token: "usdt", // token used to pay
    note: "this is demo note")  // Note 
    { [weak self] response in // Callback
    if (response.success) {
        print("Success", response)
    } else {
        print("Failed", response)
    }
}
```
SDK will display payment view as modal PageSheet from your called ViewController
### 2. SwiftUI
Call init function at root view of your app. We recommend init inside `onAppear` method
```swift
import SwiftUI
import OnePaySDK

@main
struct Demo1PayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    OnePay.initialize(
                        recipient: RECIPIENT_ADDRESS,
                        supportedTokens: ["usdt","usdc","dai"],
                        supportedNetworks: ["arbitrum"]
                    )
                }
        }
    }
}

```

After init, you can implement OnePayView as content view of sheet, for example:
```swift
import OnePaySDK
...
@State private var showingSheet = false

VStack {
...
}.sheet(isPresented: $showingSheet, content: {
    ZStack(alignment: .topTrailing) {
        OnePayView(
            amount: 0.1, // amount to pay
            token: "usdt", // token used to pay
            note: "This is demo note") // note
            .onepayFail { response in // failed callback
                print("Fail: \(response)")
            }
            .onepaySuccess { response in // success callback
                print("Success: \(response)")
            }
    }
})
```
## Handle response

#### Response object
SDK will return response whether success or fail. Response object is instance of `PaymentResponse`
```swift
public struct PaymentResponse {
    public let hash: String?
    public let success: Bool
    public let amount: Float
    public let network: String
    public let token: String
    public let note: String
}
```

#### Callback
This is a bit differences about callback of `SwiftUI` and `UIKit`. 

In `SwiftUI`, you can handle response by add self function `onepaySuccess` and `onepayFailed`.

In `UIKit`, you can handle response by single callback. Due to success or fail, `PaymentResponse.success` value is `true` or `false`

## License

1Pay.network iOS SDK is available under the MIT license. See the LICENSE file for more info.
