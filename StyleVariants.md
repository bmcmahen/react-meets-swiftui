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

SwiftUI also has something called a `ViewModifier`. Using a ViewModifier we can encapsulate combinations of view attributes for cleaner, reusable code. This means we can encapsulate combinations of `color`, `font`, `frame`, and other view attributes so that they can be easily reused.

The example below uses a `ViewModifier` to encapsulate our button intent variations.

```swift
import SwiftUI

enum ButtonIntent {
    case primary, secondary
}


struct ButtonIntentModifier : ViewModifier {

    var intent = ButtonIntent.secondary

    func getBackgroundColor(intent: ButtonIntent) -> Color {
        switch intent {
        case .primary:
            return Color.blue
        default:
            return Color.green
        }
    }

    func body(content: Content) -> some View {
        content.background(getBackgroundColor(intent: self.intent))
    }
}


struct ContactButton : View {
    var action: () -> Void
    var intent = ButtonIntent.secondary
    var label: () -> Text

    var body: some View {
        Button(action: action) {
            label()
                .color(Color.white)
                .padding()
                .modifier(ButtonIntentModifier(intent: .primary))
                .cornerRadius(5)
        }

    }
}
```

Pretty cool, eh? You can imagine how you could create highly reusable view modifiers beyond this fairly limited use-case.

We can then create a `ContactButton` like in the example below:

```swift
struct ContentView : View {

    func onContact() {
        print("contact me")
    }

    var body: some View {
        Group {
            ContactButton(action: onContact, intent: .primary) {
                Text("Contact me")
            }
        }
    }
}
```

Alternatively, we could expose the `ViewModifier` as a function on `ContactButton`:

```swift
struct ContactButton : View {
    var action: () -> Void
    var label: () -> Text

    var body: some View {
        Button(action: action) {
            label()
                .color(Color.white)
                .padding()
        }
    }

    func intent (type: ButtonIntent) -> some View {
        Modified(content: self, modifier: ButtonIntentModifier(type))
    }
}

struct ContentView : View {

    func onContact() {
        print("contact me")
    }

    var body: some View {
        Group {
            ContactButton(action: onContact) {
                Text("Contact me")
            }
            .intent(.primary)
        }
    }
}

```

In this case, I think including intent as a prop makes more sense because each button should have an intent of some sort. But you can imagine this being useful to encapsulate optional view modifiers.
