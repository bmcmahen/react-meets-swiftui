## Managing State

With SwiftUI you can create state in views and pass that state to child views, much as you would in React. You can also pass functions as props which allow child views to control state in parent components.

```jsx
import React from "react"

export function ContentView() {
  const [count, setCount] = useState(0)

  function increment() {
    setCount(count + 1)
  }

  return (
    <div>
      <div>Press the button below</div>
      <ChildView count={count} increment={increment} />
    </div>
  )
}

export function ChildView({ counter, increment }) {
  return (
    <div>
      <div>{counter}</div>
      <button onClick={increment}>Increment</button>
    </div>
  )
}
```

```swift
import SwiftUI

struct ContentView : View {
    @State var count = 0

    var body: some View {
        VStack(spacing: 1.0) {
            Text("Press the button below")
            ChildView(
                counter: count,
                increment: increment
            )
        }
    }

    func increment() {
        count += 1
    }
}


struct ChildView : View {
    var counter: Int
    var increment: () -> Void

    var body: some View {
        VStack {
            Text("\(counter)")
            Button(action: increment) {
                Text("Increment")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
```
