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
    let content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            Text("Hello: ")
            content
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
