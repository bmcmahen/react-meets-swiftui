## Style Variants

A common pattern in something like React is to create variants for something like a `Button` component, which provides primary, secondary, disabled states, etc. There are a few ways of tackling this in React.

## React

One way is to create multiple components:

```jsx
import React from "react";

function PrimaryButton({ children }) {
  return <Button style={{ color: "blue" }}>{children}</Button>;
}

function SecondaryButton({ children }) {
  return <Button style={{ color: "green" }}>{children}</Button>;
}

function Button({ style, children }) {
  const defaultStyles = {
    border: "2px solid"
  };

  return (
    <button
      style={{
        ...defaultStyles,
        ...style
      }}
    >
      {children}
    </button>
  );
}
```

The other is to have the button variants as a prop:

```jsx
import React from "react";

function Button({ type, children }) {
  const color = type === "primary" ? "blue" : "green";
  return <button style={{ color }}>{children}</button>;
}
```

## SwiftUI

Let's create a custom button with variants in Swift:

```swift
enum StyledButtonTypes {
    case primary, secondary
}

struct StyledButton : View {
    var type: StyledButtonTypes = .secondary
    var content: () -> Text

    func onTouch () {
        print("hello")
    }

    var body : some View {
        Button(action: onTouch) {
            content().color(type == .primary ? Color.blue : Color.green )
        }
    }
}
```

SwiftUI also has something called a `ViewModifier`. Using a ViewModifier we can encapsulate various view attributes that can be applied to any view. What's a `modifier` in SwiftUI? A modifier are things like `color`, `font` or other methods you call after declaring a View instance.

... TODO: ViewModifier

```swift
enum StyledButtonTypes {
    case primary, secondary
}

struct ButtonAppearance : ViewModifier {
    var type: StyledButtonTypes = .secondary

    func body(content: Content) -> some View {
        return content
    }
}
```
