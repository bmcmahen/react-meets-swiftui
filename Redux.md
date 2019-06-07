## Redux (Binding to an External Store)

SwiftUI doesn't have any concept of a reducer as either found in redux or `useReducer`. But often what motivates the use of redux is the desire to create a single source of truth within an external model or store -- stores which can be subscribed to and updated from multiple components. You can achieve this in SwiftUI using the `BindableObject` protocol and `@ObjectBinding` property wrapper.

I'm going to bypass the React example because it's quite verbose, but you can find a simple example of redux in this [counter example](https://codesandbox.io/s/github/reduxjs/redux/tree/master/examples/counter?from-embed)

## Swift

This swift example creates an external `UserStore` class which adheres to the `BindableObject` protocol, allowing Views to subscribe to changes. We indicate when changes occur using the `didChange.send` function. Our Views then update accordingly.

The `ObjectBinding` property wrapper allows us to subscribe to User models. We pass the User from the parent component (in this case, our `PreviewProvider`)

```swift
import SwiftUI
import Combine

class UserStore : BindableObject {
    var didChange = PassthroughSubject<User, Never>()
    var visible = false { didSet { didChange.send(self)  }}
    var name: String { didSet { didChange.send(self) }}

    init(name: String) {
        self.name = name
    }

    func formalName () {
        name = "Benjamin"
    }
}

struct App : View {

    @ObjectBinding var profile: UserStore

    var body : some View {
        VStack {
            Button(action: profile.formalName) {
                Text("Hello \(self.profile.name)")
            }
            Toggle(isOn: $profile.visible) {
                Text("Toggle visibility")
            }
        }
    }
}

#if DEBUG
struct App_Previews : PreviewProvider {
    static var previews: some View {
        App(profile: UserStore(name: "Ben"))
    }
}
#endif
```
