## Using Spacer()

In addition to `HStack` and `VStack`, `Spacer` is probably one of the most important Views for creating layouts. This is especially so because by default Views only take up as little space as required. Let's look at an example:

```jsx
<div style={{ display: "block", background: "blue" }}>
  <span>Hello world</span>
</div>
```

Coming from a web background, you'll know that our `div` will extend fully horizontally to cover the space available to it. By comparison, SwiftUI will only take up the minimum space required.

```swift
HStack {
  Text("Hello world")
}.background(Color.blue)
```

The blue background will only cover the width of the contained text. Let's use `Spacer` to change this.

```swift
HStack {
  Text("Hello world")
  Spacer()
}.background(Color.blue)
```

Using a spacer results in the equivalent `block` style that's exhibited in our HTML above.

In general, you'll want to rely on `Spacer`, `HStack`, and `VStack` more than supplying viewport coordinates to the frame modifier.
