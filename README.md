# Reachable Package

A Swift package for network reachability monitoring using Apple's `Network` framework, with support for RxSwift for reactive programming. This package supports both UIKit and SwiftUI, with compatibility for iOS 12 and above for UIKit and iOS 14 and above for SwiftUI

## Features

-   Network reachability monitoring
-   Reactive programming with RxSwift (iOS 12+)
-   Support for UIKit and SwiftUI

## Usage

On UIKit, supported versions are from iOS 12.0+

```swift
import UIKit
import Reachable

class ViewController: UIViewController {
    private var reachabilityObserver: ReachabilityObserver?
    override func viewDidLoad() {
        super.viewDidLoad()
        reachabilityObserver = ReachabilityObserver { status in
            if status == .unsatisfied {
                print("Network is unsatisfied. Performing task...")
                // Perform your task here
            }
        }
    }
}
```

On SwiftUI, this is the implementation, to reduce complexity, it is constrained to iOS 14.0+

```swift
import SwiftUI
import Reachable

@available(iOS 14.0, *)
struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .onReachabilityChange { status in
                if status == .unsatisfied {
                    print("Network is unsatisfied. Performing task...")
                    // Perform your task here
                }
            }
    }
}
```
