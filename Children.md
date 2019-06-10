## Children

This example shows a common `Layout`, `Content` composition pattern which I commonly use in React, and is the key to developing reusable, flexible components.

### React

```jsx
import React from "react";

function Page() {
  return (
    <Layout>
      <span>This is the page content</span>
    </Layout>
  );
}

function Layout({ children }) {
  return (
    <div>
      <span>This is the layout</span>
      {children}
    </div>
  );
}
```

### SwiftUI

With SwiftUI you can utilize the `@ViewBuilder` function wrapper to accept arbitrary children. Further details and explanation can be found [here](https://stackoverflow.com/questions/56532366/using-viewbuilder-to-create-views-which-support-multiple-children)

Let me try to explain some details:

`Layout<Content>` is an example of Generics in Swift. If you've ever used Typescript, you know about generics. I like to think of generics kinda like sending mail. When you send mail, you know what's contained in the parcel and the recipient does too - but the postal service doesn't know the exact contents. But it nevertheless knows something is there, and it's able to handle the contents without really knowing the exact details. Generics allow you to call a function with different types and receive that same type back, even if the function doesn't know if it's an Int, String, etc.

The `where` clause specifies a generic constraint - i.e, that `Content` conform to the `View` protocol.

So we can read this first statement as: create a layout that accepts some type of child. This layout conforms to the View protocol, and our content type also conforms to that protocol.

I'm not sure if `@escaping` is totally necessary. But it means that the contents of our closure could possibly outlast the context from which it's called. Check the stackoverflow post above for more details.

```swift
struct ContentView : View {
    var body: some View {
        HStack {
            Text("Hello:")
            Layout {
                Text("Ben")
                Text("McMahen")
            }
        }

    }
}

struct Layout<Content>: View where Content: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            Text("Hello: ")
            content()
        }
    }
}
```

You can also specify the child type. In this example, we require that the child is `Text`:

```swift
import SwiftUI

struct Page : View {
    var body: some View {
        Layout() {
            Text("This is the page content")
        }
    }
}

struct Layout : View {

    var content: () -> Text

    var body: some View {
        VStack {
            Text("This is the layout")
            content()
        }
    }
}

```
